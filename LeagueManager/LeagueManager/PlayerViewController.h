//
//  PlayerViewController.h
//  LeagueManager
//
//  Created by Nikolay Shatilo on 30.09.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface PlayerViewController : UITableViewController

@property (nonatomic, retain) MasterViewController *masterViewController;

@property (nonatomic, retain) NSManagedObject *team;

@end
