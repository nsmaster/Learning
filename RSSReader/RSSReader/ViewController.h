//
//  ViewController.h
//  RSSReader
//
//  Created by Nikolay Shatilo on 24.02.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
