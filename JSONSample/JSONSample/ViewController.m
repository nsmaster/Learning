//
//  ViewController.m
//  JSONSample
//
//  Created by Nikolay Shatilo on 27.02.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@property (nonatomic, strong) NSDictionary *weather;

@end

@implementation ViewController

NSString * const baseUrl = @"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json";

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

- (NSDictionary *)weather
{
    if(!_weather) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:baseUrl]];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                               message:[error localizedDescription]
                                                              delegate:nil
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil];
            [alertView show];

        }];
        
        [operation start];
    }
    
    return _weather;
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!self.weather)
        return 0;
    
    switch (section) {
        case 0: {
            return 1;
        }
        case 1: {
            //NSArray *upcomingWeather = [self.weather upcomingWeather];
            //return [upcomingWeather count];
            return 0 ;
        }
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
