//
//  NS_Section.h
//  EditingAndOrderingTable
//
//  Created by Nikolay Shatilo on 30.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NS_Section : NSObject

@property (nonatomic) NSString *name;

@property (nonatomic) NSMutableArray *items;

- (id)initWithName:(NSString *)name;

@end
