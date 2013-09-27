//
//  AppDelegate.h
//  VKClient
//
//  Created by Nikolay Shatilo on 25.09.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ViewController.h"
#import "VKConnector.h"
#import "VKRequest.h"
#import "VKUser.h"
#import "VKAccessToken.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate, VKConnectorDelegate, VKRequestDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
