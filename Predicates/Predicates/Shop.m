//
//  Shop.m
//  Predicates
//
//  Created by Nikolay Shatilo on 06.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "Shop.h"

@implementation Shop

- (id)initWithName:(NSString *)aName
{
    self = [super init];
    if(self) {
        _name = aName;
    }
    
    return self;
}

- (id)initWithName:(NSString *)aName products:(NSArray *)aProducts
{
    self = [self initWithName:aName];
    if(self) {
        _products = aProducts;
    }
    
    return self;
}

@end
