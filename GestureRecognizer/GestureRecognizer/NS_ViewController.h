//
//  NS_ViewController.h
//  GestureRecognizer
//
//  Created by Nikolay Shatilo on 31.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NS_ViewController : UIViewController <UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIRotationGestureRecognizer *rotationGesture;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGesture;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGesture;

@end
