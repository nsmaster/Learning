//
//  NS_ViewController.m
//  NotificationCenterAndKVO
//
//  Created by Nikolay Shatilo on 21.11.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "NS_ViewController.h"
#import "NS_FantasikBook.h"

@interface NS_ViewController ()
{
    NS_FantasikBook *book;
    NSMutableArray *bookNameChanges;
}

@end

@implementation NS_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    book = [[NS_FantasikBook alloc] init];
    [book addObserver:self forKeyPath:@"Name" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    
    bookNameChanges = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString *newValue = [change objectForKey:NSKeyValueChangeNewKey];
    [bookNameChanges addObject:newValue];
    
    [self.tableView ]
}

#pragma mark TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bookNameChanges.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell
}

- (IBAction)changeBookName:(id)sender {
}
@end
