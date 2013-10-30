//
//  ViewController.m
//  LearningTest
//
//  Created by Nikolay Shatilo on 17.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "MasterViewController.h"
#import "Step1ViewController.h"
#import "Step2ViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTouchDown:(id)sender
{
    Step1ViewController *step1Controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Step1"];
    
    [self presentViewController:step1Controller animated:YES completion:nil];
}

@end
