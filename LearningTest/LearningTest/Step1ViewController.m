//
//  Step1ViewController.m
//  LearningTest
//
//  Created by Nikolay Shatilo on 17.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "Step1ViewController.h"
#import "Step2ViewController.h"

@interface Step1ViewController ()

@end

@implementation Step1ViewController

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

- (IBAction)Step2ButtonTochDown:(id)sender
{
    Step2ViewController *step2Controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Step2"];
    step2Controller.delegate = self;
    
    [self presentViewController:step2Controller animated:YES completion:nil];
}

- (void)Closing
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
