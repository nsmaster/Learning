//
//  ViewController.h
//  RssReader
//
//  Created by Nikolay Shatilo on 18.03.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssManager.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RssManagerDelegate>

@end
