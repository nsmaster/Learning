//
//  NewsItem.h
//  RssReader
//
//  Created by Nikolay Shatilo on 20.03.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSURL *link;

@end
