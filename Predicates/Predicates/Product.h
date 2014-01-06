//
//  Product.h
//  Predicates
//
//  Created by Nikolay Shatilo on 03.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, strong, readonly) NSString *name;

@property (nonatomic, strong, readonly) NSNumber *cost;

- (id)initWithName:(NSString *)aName cost:(NSNumber *)aCost;

- (id)init __attribute__((unavailable()));

@end
