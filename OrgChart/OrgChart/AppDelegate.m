//
//  AppDelegate.m
//  OrgChart
//
//  Created by Nikolay Shatilo on 27.09.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [self createData];
    [self readData];
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - CoreData

- (NSManagedObjectModel *)managedObjectModel
{
    if(_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"OrgChart" withExtension:@"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *path = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    path = [path URLByAppendingPathComponent:@"OrgChart.sqlite"];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSError *error;
    
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:path options:nil error:&error]) {
        NSLog(@"persistent store error");
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if(_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    
    if(coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if(nil != managedObjectContext) {
        if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]){
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)createData
{
    NSManagedObject *organization = [NSEntityDescription insertNewObjectForEntityForName:@"Organization" inManagedObjectContext:self.managedObjectContext];
    
    NSString *companyName = @"My comapny, Inc";
    
    [organization setValue:companyName forKey:@"name"];
    [organization setValue:[NSNumber numberWithInt:[companyName hash]] forKey:@"id"];
    
    
    NSManagedObject *john = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    [john setValue:@"John" forKey:@"name"];
    [john setValue:[NSNumber numberWithInt:[@"John" hash]] forKey:@"id"];
    
    NSManagedObject *jane = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    [jane setValue:@"Jane" forKey:@"name"];
    [jane setValue:[NSNumber numberWithInt:[@"Jane" hash]] forKey:@"id"];
    
    NSManagedObject *bill = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    [bill setValue:@"Bill" forKey:@"name"];
    [bill setValue:[NSNumber numberWithInt:[@"Bill" hash]] forKey:@"id"];
    
    [organization setValue:john forKey:@"leader"];
    
    NSMutableSet *employees = [john mutableSetValueForKey:@"employees"];
    [employees addObject:jane];
    [employees addObject:bill];
    
    [self saveContext];
}

- (void)readData
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *orgEntity = [NSEntityDescription entityForName:@"Organization" inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:orgEntity];
    
    NSArray *organizations = [context executeFetchRequest:fetchRequest error:nil];
    
    id organization;
    NSEnumerator *it = [organizations objectEnumerator];
    while ((organization = [it nextObject]) != nil)
    {
        NSLog(@"Organization: %@", [organization valueForKey:@"name"]);
        
        NSManagedObject *ceo = [organization valueForKey:@"leader"];
        [self displayPerson:ceo withIndentation:@"  "];
    }
}

- (void)displayPerson:(NSManagedObject *)person withIndentation:(NSString *)indentation
{
    NSLog(@"%@Name: %@", indentation, [person valueForKey:@"name"]);
    
    // увеличиваем значение для подуровней
    indentation = [NSString stringWithFormat:@"%@ ", indentation];
    
    NSSet *employees = [person valueForKey:@"employees"];
    id employee;
    NSEnumerator *it = [employees objectEnumerator];
    while((employee = [it nextObject]) != nil)
    {
        [self displayPerson:employee withIndentation:indentation];
    }
}

@end
