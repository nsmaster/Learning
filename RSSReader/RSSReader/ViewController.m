//
//  ViewController.m
//  RSSReader
//
//  Created by Nikolay Shatilo on 24.02.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"
#import "RSSEntry.h"
#import <AFNetworking.h>
#import "AFAppDotNetAPIClient.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;


@property (nonatomic, strong) NSDictionary *weather;

@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

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

- (NSMutableArray *)rssEntries
{
    if(!_rssEntries) {
        _rssEntries = [[NSMutableArray alloc] init];
        
        //stream/0/posts/stream/global
//        [[AFAppDotNetAPIClient sharedClient] GET:@"stream/0/posts/stream/global" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSArray *postsFromResponse = [responseObject valueForKeyPath:@"data"];
//            
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
//            NSLog(@"Response statusCode: %i", response.statusCode);
//        }];
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://podrobnosti.ua/"]];
//        AFURLConnectionOperation *operation = [[AFURLConnectionOperation alloc] initWithRequest:request];
//        
//        [operation setCompletionBlock:^ {
//            id data = operation.responseData;
//        }];
//        [operation start];

        static NSString * const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";
        
        NSString *string = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
        NSURL *url = [NSURL URLWithString:string];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // 2
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 3
            self.weather = (NSDictionary *)responseObject;
            self.title = @"JSON Retrieved";
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 4
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
        
        // 5
        [operation start];
        
    }
    
    return _rssEntries;
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
            NSArray *upcomingWeather = [self.weather upcomingWeather];
            return [upcomingWeather count];
        }
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    return cell;
}

@end
