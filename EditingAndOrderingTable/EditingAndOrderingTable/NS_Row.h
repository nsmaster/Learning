//
//  NS_Row.h
//  EditingAndOrderingTable
//
//  Created by Nikolay Shatilo on 30.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NS_Row : NSObject

@property (nonatomic) NSString *name;

@property (nonatomic) NSString *description;

- (id)initWithName:(NSString *)name andDescription:(NSString *)description;

@end
