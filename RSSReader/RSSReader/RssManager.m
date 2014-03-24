//
//  RssManager.m
//  RssReader
//
//  Created by Nikolay Shatilo on 20.03.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "RssManager.h"
#import "AFNetworking.h"

@implementation RssManager

- (void)startUpload:(NSString *)url
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
        
        [operationQueue addOperationWithBlock:^{
            RssParser *rssParser = [[RssParser alloc] initWithXMLParser:responseObject];
            rssParser.delegate = self;
            [rssParser start];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [operation start];
}

- (void)didNewsItemUpload:(NewsItem *)newsItem
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.delegate addNewNewsItem:newsItem];
    }];
}

@end
