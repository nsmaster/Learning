//
//  Step2ViewController.h
//  LearningTest
//
//  Created by Nikolay Shatilo on 17.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Step2Delegate <NSObject>

- (void)Closing;

@end

@interface Step2ViewController : UIViewController

@property (nonatomic) id<Step2Delegate> delegate;

@end


