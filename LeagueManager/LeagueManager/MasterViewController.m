//
//  MasterViewController.m
//  LeagueManager
//
//  Created by Nikolay Shatilo on 28.09.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "MasterViewController.h"
#import "TeamViewController.h"
#import "PlayerListViewController.h"
#import "CustomCellContent.h"

@interface MasterViewController ()
{
    NSIndexPath *deleteItem;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = NSLocalizedString(@"League Manager", @"League Manager");
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showTeamView)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)showTeamView
{
    UIStoryboard *storyBoard = self.storyboard;
    
    TeamViewController *teamViewController = [storyBoard instantiateViewControllerWithIdentifier:@"TeamProperties"];
    teamViewController.masterController = self;

    [self.navigationController pushViewController:teamViewController animated:YES];
    
//    [self presentViewController:teamViewController animated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        id object = [self.fetchedResultsController objectAtIndexPath:deleteItem];
        
        [self.managedObjectContext deleteObject:object];
        
        [self saveContext];
    }
    else {
        [self.tableView setEditing:NO animated:YES];
    }
}

#pragma mark - Table View DataSource and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CeelId = @"TeamCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CeelId];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CeelId];
        
        CustomCellContent *customCell = [[CustomCellContent alloc] initWithFrame:cell.contentView.frame];
        
        customCell.tag = 8;
        
        [cell.contentView addSubview:customCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do want to delete the team?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:nil];
        
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        deleteItem = indexPath;
        
        [actionSheet showInView:self.view];
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"teamProperties"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        TeamViewController *controller = [segue destinationViewController];
        
        controller.masterController = self;
        controller.team = object;
    }
    
    if([[segue identifier] isEqualToString:@"playerList"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        PlayerListViewController *controller = [segue destinationViewController];
        
        controller.masterViewController = self;
        controller.team = object;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexTitles = [[NSMutableArray alloc] init];
    
    for (id<NSFetchedResultsSectionInfo> item in [self.fetchedResultsController sections]) {
        [indexTitles addObject:item.indexTitle];
    }
    
    return indexTitles;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    return sectionInfo.indexTitle;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Team" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"indexTitle" cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CustomCellContent *customCellContent = (CustomCellContent *)[cell.contentView viewWithTag:8];
    
    customCellContent.title = [[object valueForKey:@"name"] description];
    
//    cell.textLabel.text = [[object valueForKey:@"name"] description];
//    cell.detailTextLabel.text = [[object valueForKey:@"uniformColor"] description];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
}

- (void)insertTeamWithName:(NSString *)name uniformColor:(NSString *)uniformColor
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    [newManagedObject setValue:name forKey:@"name"];
    [newManagedObject setValue:uniformColor forKey:@"uniformColor"];
    [newManagedObject setValue:[name substringToIndex:1] forKey:@"indexTitle"];
    
    [self saveContext];
}

- (void)saveContext
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSError *error = nil;
    
    if(![context save:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
