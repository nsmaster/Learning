//
//  Shop.h
//  Predicates
//
//  Created by Nikolay Shatilo on 06.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject

@property (nonatomic, strong, readonly) NSString *name;

@property (nonatomic, strong) NSMutableArray *products;

- (id)initWithName:(NSString *)aName;

- (id)initWithName:(NSString *)aName products:(NSMutableArray *)aProducts;

- (id)init __attribute__((unavailable()));

@end
