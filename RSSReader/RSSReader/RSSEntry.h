//
//  RSSEntry.h
//  RSSReader
//
//  Created by Nikolay Shatilo on 26.02.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSEntry : NSObject

@property (nonatomic, strong) NSString *blogTitle;
@property (nonatomic, strong) NSString *articleTitle;
@property (nonatomic, strong) NSString *articleUrl;
@property (nonatomic, strong) NSDate *articleDate;

- (id)initWithBlogTitle:(NSString*)aBlogTitle articleTitle:(NSString*)aArticleTitle articleUrl:(NSString*)aArticleUrl articleDate:(NSDate*)aArticleDate;

@end
