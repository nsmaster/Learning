//
//  ViewController.m
//  RssReader
//
//  Created by Nikolay Shatilo on 18.03.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"
#import "NewsItem.h"
#import "WebViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *newsItems;

@property (nonatomic, strong) RssManager *rssManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateData)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [self cleanData];
}

- (void)cleanData
{
    self.newsItems = nil;
    self.rssManager = nil;
}

- (void)updateData
{
    [self cleanData];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"web"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NewsItem *newsItem = [self.newsItems objectAtIndex:indexPath.row];
        
        WebViewController *controller = segue.destinationViewController;
        controller.link = newsItem.link;
    }
}

- (NSMutableArray *)newsItems
{
    if (!_newsItems) {
        _newsItems = [[NSMutableArray alloc] init];
        
        [self.rssManager startUpload:@"http://espreso.tv/rss"];
        [self.rssManager startUpload:@"http://iphones.ru/rss"];
    }
    
    return _newsItems;
}

- (RssManager *)rssManager
{
    if(!_rssManager) {
        _rssManager = [[RssManager alloc] init];
        _rssManager.delegate = self;
    }
    
    return _rssManager;
}

#pragma mark - RssManager

- (void)addNewNewsItem:(NewsItem *)newsItem
{
    NSInteger count = [self.newsItems count];
    [self.newsItems addObject:newsItem];
    
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:count inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.newsItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RssCell"];
    
    NewsItem *newsItem = [self.newsItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = newsItem.title;
    
    return cell;
}


@end
