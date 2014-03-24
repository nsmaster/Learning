//
//  WebViewController.m
//  RssReader
//
//  Created by Nikolay Shatilo on 21.03.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

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
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.link]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
