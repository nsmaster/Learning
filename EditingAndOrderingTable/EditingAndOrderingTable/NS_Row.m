//
//  NS_Row.m
//  EditingAndOrderingTable
//
//  Created by Nikolay Shatilo on 30.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "NS_Row.h"

@implementation NS_Row

- (id)initWithName:(NSString *)name andDescription:(NSString *)description
{
    self = [super init];
    
    if(self) {
        self.name = name;
        self.description = description;
    }
        
    return self;
}

@end
