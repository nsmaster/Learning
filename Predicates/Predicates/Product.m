//
//  Product.m
//  Predicates
//
//  Created by Nikolay Shatilo on 03.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "Product.h"

@implementation Product

- (id)initWithName:(NSString *)aName cost:(NSNumber *)aCost
{
    self = [super init];
    if(self) {
        _name = aName;
        _cost = aCost;
    }
    
    return self;
}

@end
