//
//  ViewController.m
//  Localization
//
//  Created by Nikolay Shatilo on 16.02.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.titleLabel.text = NSLocalizedString(@"TITLE", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
