//
//  NS_MainViewController.m
//  EditingAndOrderingTable
//
//  Created by Nikolay Shatilo on 30.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "NS_MainViewController.h"
#import "NS_Section.h"
#import "NS_Row.h"

@interface NS_MainViewController ()
{
    NSMutableArray *sections;
}

@end

@implementation NS_MainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sections = [[NSMutableArray alloc] init];
    
    [self fillSections];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editTable:(id)sender
{
    UIBarButtonItem *button = sender;
    
    if (self.editing) {
        [self setEditing:NO animated:YES];
        button.style = UIBarButtonSystemItemEdit;
        
    }
    else {
        [self setEditing:YES animated:YES];
        button.style = UIBarButtonSystemItemDone;
    }
}

- (void)fillSections
{
    NS_Section *section1 = [[NS_Section alloc] initWithName:@"Section 1"];
    
    [section1.items addObject:[[NS_Row alloc] initWithName:@"row_1_1" andDescription:nil]];
    [section1.items addObject:[[NS_Row alloc] initWithName:@"row_1_2" andDescription:nil]];
    [section1.items addObject:[[NS_Row alloc] initWithName:@"row_1_3" andDescription:nil]];
    [section1.items addObject:[[NS_Row alloc] initWithName:@"row_1_4" andDescription:nil]];
    [section1.items addObject:[[NS_Row alloc] initWithName:@"row_1_5" andDescription:nil]];
    
    [sections addObject:section1];
    
    NS_Section *section2 = [[NS_Section alloc] initWithName:@"Section 2"];
    
    [section2.items addObject:[[NS_Row alloc] initWithName:@"row_2_1" andDescription:nil]];

    [sections addObject:section2];
    
    NS_Section *section3 = [[NS_Section alloc] initWithName:@"Section 3"];
    
    [section3.items addObject:[[NS_Row alloc] initWithName:@"row_3_1" andDescription:nil]];
    [section3.items addObject:[[NS_Row alloc] initWithName:@"row_3_2" andDescription:nil]];
    [section3.items addObject:[[NS_Row alloc] initWithName:@"row_3_3" andDescription:nil]];

    
    [sections addObject:section3];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[(NS_Section *)[sections objectAtIndex:section] items] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [(NS_Section *)[sections objectAtIndex:section] name];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NS_Row *row = [[(NS_Section *)[sections objectAtIndex:indexPath.section] items] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = row.name;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
