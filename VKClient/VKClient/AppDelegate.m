//
//  AppDelegate.m
//  VKClient
//
//  Created by Nikolay Shatilo on 25.09.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    // Override point for customization after application launch.
//    self.viewController = [[ViewController alloc] init];
//    self.window.rootViewController = self.viewController;
//    [self.window makeKeyAndVisible];
    
    [[VKConnector sharedInstance] setDelegate:self];
    [[VKConnector sharedInstance] startWithAppID:@"3541027" permissons:@[@"friends"]];
    
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

#pragma mark - VKConnectorDelegate

- (void)VKConnector:(VKConnector *)connector accessTokenRenewalSucceeded:(VKAccessToken *)accessToken
{
    NSLog(@"Log token: %@", accessToken);
    
    [[VKUser currentUser] setDelegate:self];
    [[VKUser currentUser] friendsGet:@{@"uid" : @([VKUser currentUser].accessToken.userID),
                                       @"fields" : @"first_name,last_name,photo,status"}];
}

- (void)VKConnector:(VKConnector *)connector accessTokenRenewalFailed:(VKAccessToken *)accessToken
{
    NSLog(@"User denied app authorization");
}

#pragma mark - VKRequestDelegate
- (void)VKRequest:(VKRequest *)request response:(id)response
{
    ViewController *controller = (ViewController *)self.window.rootViewController;
    
    controller.userFriends = response[@"response"];
    [controller.tableView reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
    ^{
        for (NSDictionary *user in  controller.userFriends) {
            NSManagedObject *friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.managedObjectContext];
            
            [friend setValue:user[@"first_name"] forKey:@"firstName"];
            [friend setValue:user[@"last_name"] forKey:@"lastName"];
            [friend setValue:user[@"photo"] forKey:@"photo"];
            [friend setValue:[NSData dataWithContentsOfURL:[NSURL URLWithString:user[@"photo"]]] forKey:@"photoData"];
            [friend setValue:user[@"status"] forKey:@"status"];
            
            //NSLog(@"friend: %@", friend);
        }
        
        //[self.managedObjectContext save:nil];
    });
}

-(void)VKRequest:(VKRequest *)request connectionErrorOccured:(NSError *)error
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Friend"];
    
    NSArray *friends = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    
}

#pragma mark - Core Data

- (NSManagedObjectModel *)managedObjectModel
{
    if(_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    return _managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *url = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"VKClients.sqlite"];
    
    NSError *error;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]){
        NSLog(@"PersistentStore creation error: %@", error);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if(_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    if(self.persistentStoreCoordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return _managedObjectContext;
}
@end
