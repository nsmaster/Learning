//
//  ViewController.h
//  VKClient
//
//  Created by Nikolay Shatilo on 25.09.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *userFriends;

@end
