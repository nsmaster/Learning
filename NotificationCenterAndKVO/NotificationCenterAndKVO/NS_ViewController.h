//
//  NS_ViewController.h
//  NotificationCenterAndKVO
//
//  Created by Nikolay Shatilo on 21.11.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NS_ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
- (IBAction)changeBookName:(id)sender;

@end
