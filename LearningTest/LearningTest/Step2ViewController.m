//
//  Step2ViewController.m
//  LearningTest
//
//  Created by Nikolay Shatilo on 17.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "Step2ViewController.h"

@interface Step2ViewController ()

@end

@implementation Step2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToStep1:(id)sender
{
    [self.delegate Closing];
}

@end
