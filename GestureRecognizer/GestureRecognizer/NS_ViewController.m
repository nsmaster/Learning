//
//  NS_ViewController.m
//  GestureRecognizer
//
//  Created by Nikolay Shatilo on 31.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "NS_ViewController.h"

@interface NS_ViewController ()

@end

@implementation NS_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:tapGesture];
    [self.panGesture requireGestureRecognizerToFail:self.swipeGesture];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapGesture:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];
    
    [UIView animateWithDuration:0.5 animations:^(void){
        self.imageView.center = point;
    }];
}

- (IBAction)showGestureForRotationRecognizer:(UIRotationGestureRecognizer *)sender
{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, sender.rotation);
    sender.rotation = 0;
    
}
- (IBAction)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.view];
    CGPoint center = sender.view.center;
    
    sender.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [sender setTranslation:CGPointZero inView:self.view];
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)sender
{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, sender.scale, sender.scale);
    sender.scale = 1;
}

- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)sender
{
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
