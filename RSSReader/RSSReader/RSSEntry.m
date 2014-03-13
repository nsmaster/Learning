//
//  RSSEntry.m
//  RSSReader
//
//  Created by Nikolay Shatilo on 26.02.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "RSSEntry.h"

@implementation RSSEntry

- (id)initWithBlogTitle:(NSString*)aBlogTitle articleTitle:(NSString*)aArticleTitle articleUrl:(NSString*)aArticleUrl articleDate:(NSDate*)aArticleDate
{
    self = [super init];
    
    if(self) {
        _blogTitle = aBlogTitle;
        _articleTitle = aArticleTitle;
        _articleUrl = aArticleUrl;
        _articleDate = aArticleDate;
    }
    
    return self;
}

@end
