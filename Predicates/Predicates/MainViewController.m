//
//  MainViewController.m
//  Predicates
//
//  Created by Nikolay Shatilo on 03.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "MainViewController.h"
#import "ProductViewController.h"
#import "ShopViewController.h"
#import "Product.h"
#import "Shop.h"

@interface MainViewController ()

@property (nonatomic, strong) NSArray *products;

@property (nonatomic, strong) NSArray *shops;

@end

@implementation MainViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    self.products = nil;
    self.shops = nil;
}

- (NSArray *)products
{
    if(!_products) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        [array addObject:[[Product alloc] initWithName:@"Item 1" cost:[NSNumber numberWithDouble:3.14]]];
        [array addObject:[[Product alloc] initWithName:@"Item 2" cost:[NSNumber numberWithDouble:3.15]]];
        [array addObject:[[Product alloc] initWithName:@"Item 3" cost:[NSNumber numberWithDouble:5.10]]];
        [array addObject:[[Product alloc] initWithName:@"Item 4" cost:[NSNumber numberWithDouble:8.15]]];
        [array addObject:[[Product alloc] initWithName:@"Item 5" cost:[NSNumber numberWithDouble:2.45]]];
        [array addObject:[[Product alloc] initWithName:@"Item 6" cost:[NSNumber numberWithDouble:3.55]]];
        [array addObject:[[Product alloc] initWithName:@"Item 7" cost:[NSNumber numberWithDouble:5.14]]];
        [array addObject:[[Product alloc] initWithName:@"Item 8" cost:[NSNumber numberWithDouble:9.90]]];

        _products = array;
    }
    
    return _products;
}

- (NSArray *)shops
{
    if(!_shops) {
        Shop * shop1 = [[Shop alloc] initWithName:@"Shop 1"];
        
        shop1.products = @[[[Product alloc] initWithName:@"Item 1" cost:[NSNumber numberWithDouble:3.14]],
                           [[Product alloc] initWithName:@"Item 2" cost:[NSNumber numberWithDouble:3.15]]];
        
        Shop * shop2 = [[Shop alloc] initWithName:@"Shop 2"];
        Shop * shop3 = [[Shop alloc] initWithName:@"Shop 3"];
        
        _shops = @[shop1, shop2, shop3];
    }
    
    return _shops;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"allItems"]) {
        ProductViewController *controller = segue.destinationViewController;
        
        controller.products = self.products;
    } else if ([segue.identifier isEqualToString:@"inCollection"]) {
        ProductViewController *controller = segue.destinationViewController;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cost IN %@", @[[NSNumber numberWithDouble:3.14], [NSNumber numberWithDouble:3.15]]];
        
        controller.products = [self.products filteredArrayUsingPredicate:predicate];
    } else if ([segue.identifier isEqualToString:@"moreThanFour"]) {
        ProductViewController *controller = segue.destinationViewController;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cost >= %@", [NSNumber numberWithDouble:4]];
        
        controller.products = [self.products filteredArrayUsingPredicate:predicate];
    } else if ([segue.identifier isEqualToString:@"allShops"]) {
        ShopViewController *controller = segue.destinationViewController;
        
        controller.shops = self.shops;
        controller.navigationItem.title = @"Shops";
    } else if ([segue.identifier isEqualToString:@"moreThanOneProducts"]) {
        ShopViewController *controller = segue.destinationViewController;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"products.count > 1"];
        
        controller.shops = [self.shops filteredArrayUsingPredicate:predicate];
        controller.navigationItem.title = @"Shops";

    }
}

@end
