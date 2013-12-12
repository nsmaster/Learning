//
//  NS_Section.m
//  EditingAndOrderingTable
//
//  Created by Nikolay Shatilo on 30.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "NS_Section.h"

@implementation NS_Section

- (id)initWithName:(NSString *)name
{
    self = [super init];
    
    if(self) {
        self.name = name;
        self.items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
