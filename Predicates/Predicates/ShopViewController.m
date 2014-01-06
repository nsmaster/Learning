//
//  ShopViewController.m
//  Predicates
//
//  Created by Nikolay Shatilo on 06.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "ShopViewController.h"
#import "Shop.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.shops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = ((Shop *)[self.shops objectAtIndex:indexPath.row]).name;
    
    return cell;
}


@end
