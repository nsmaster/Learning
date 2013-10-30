//
//  Step1ViewController.h
//  LearningTest
//
//  Created by Nikolay Shatilo on 17.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Step2ViewController.h"

@interface Step1ViewController : UIViewController <Step2Delegate>

- (IBAction)Step2ButtonTochDown:(id)sender;

@end
