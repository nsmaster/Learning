//
//  RssParser.h
//  RssReader
//
//  Created by Nikolay Shatilo on 18.03.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsItem.h"

@protocol RssParserDelegate <NSObject>

- (void)didNewsItemUpload:(NewsItem *)newsItem;

@end

@interface RssParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) id<RssParserDelegate> delegate;

@property (nonatomic, strong) NSXMLParser *XMLParser;

- (id)initWithXMLParser:(NSXMLParser *)aXMLParser;

- (void)start;

@end
