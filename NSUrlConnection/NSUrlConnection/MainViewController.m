//
//  MainViewController.m
//  NSUrlConnection
//
//  Created by Nikolay Shatilo on 08.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "MainViewController.h"
#import "MyInterface.h"
#import "MyProtocol.h"

@interface MainViewController ()

@property (nonatomic, strong) NSMutableData *receivedData;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MainViewController

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
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"http://wareous.com/guest/country_list/ukraine.png"]];
    self.receivedData = [[NSMutableData alloc] init];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(!connection) {
        self.receivedData = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [[UIImage alloc] initWithData:self.receivedData];
    });
}

@end
