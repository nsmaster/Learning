//
//  NS_Book.m
//  NotificationCenterAndKVO
//
//  Created by Nikolay Shatilo on 21.11.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "NS_Book.h"

@interface NS_Book ()
{
    NSString *authorName;
}

- (NSNumber *)GetCountOfPages;
@end

@implementation NS_Book

- (id)init
{
    self = [super init];
    
    if(self){
        _Name = @"My book";
    }
    
    return self;
}

- (NSNumber *)GetCountOfPages
{
    return [[NSNumber alloc] initWithInt:10];
}


@end
