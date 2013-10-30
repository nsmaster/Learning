//
//  PlayerViewController.h
//  LeagueManager
//
//  Created by Nikolay Shatilo on 30.09.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface PlayerListViewController : UITableViewController

@property (nonatomic, weak) MasterViewController *masterViewController;

@property (nonatomic, weak) NSManagedObject *team;

@end
