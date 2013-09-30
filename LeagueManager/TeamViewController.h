//
//  TeamViewController.h
//  LeagueManager
//
//  Created by Nikolay Shatilo on 28.09.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface TeamViewController : UITableViewController<UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *uniformColor;
@property (nonatomic, retain) NSManagedObject *team;
@property (nonatomic, retain) MasterViewController *masterController;

- (id)initWithMasterController:(MasterViewController *)masterController team:(NSManagedObject *)team;

@end
