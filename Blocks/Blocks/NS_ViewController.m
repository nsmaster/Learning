//
//  NS_ViewController.m
//  Blocks
//
//  Created by Nikolay Shatilo on 12.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "NS_ViewController.h"

@interface NS_ViewController ()

@end

@implementation NS_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self showResult:^(int x, int y){ return x + y;}];
    [self showResult:^(int x, int y){ return x - y;}];
    [self showResult:^(int x, int y){ return x * y;}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showResult:(GetResult) incomingData
{
    NSLog(@"result: %i", incomingData(5, 4));
}

@end
