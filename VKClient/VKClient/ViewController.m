//
//  ViewController.m
//  VKClient
//
//  Created by Nikolay Shatilo on 25.09.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_userFriends count];
}

- (void)loadImagePath:(NSString *)imgPath inCell:(NSIndexPath *)indexPath
{
    NSData* img = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgPath]];
    
    _userFriends[(NSInteger)indexPath.row][@"photoData"] = img;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    });
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"CellId";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellId];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
    }
    
    
    if(_userFriends[(NSInteger)indexPath.row][@"photoData"] == nil) {
        cell.imageView.image = [UIImage imageNamed:@"default.png"];
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSString* imgPath = _userFriends[(NSUInteger)indexPath.row][@"photo"];
            
            [self loadImagePath:imgPath inCell:indexPath];
        });
    }
    else {
        cell.imageView.image = [UIImage imageWithData:_userFriends[(NSInteger)indexPath.row][@"photoData"]];
    }
    
    NSString* firstName = _userFriends[(NSUInteger)indexPath.row][@"first_name"];
    NSString* lastName = _userFriends[(NSUInteger)indexPath.row][@"last_name"];
    NSString* fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    cell.textLabel.text = fullName;
    
    NSString* status = _userFriends[(NSUInteger)indexPath.row][@"status"];
    cell.detailTextLabel.text = status;
    
    return cell;
}

@end
