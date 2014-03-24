//
//  RssManager.h
//  RssReader
//
//  Created by Nikolay Shatilo on 20.03.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssParser.h"
@class NewsItem;

@protocol RssManagerDelegate <NSObject>

- (void)addNewNewsItem:(NewsItem *)newsItem;

@end

@interface RssManager : NSObject <RssParserDelegate>

@property (nonatomic, strong) id<RssManagerDelegate> delegate;

- (void)startUpload:(NSString *)url;

@end
