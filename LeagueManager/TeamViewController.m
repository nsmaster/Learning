//
//  TeamViewController.m
//  LeagueManager
//
//  Created by Nikolay Shatilo on 28.09.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "TeamViewController.h"
#import "PlayerDetailViewController.h"

@interface TeamViewController ()

@end

@implementation TeamViewController

//- (void)loadView
//{
//    [super loadView];
//}

- (id)initWithMasterController:(MasterViewController *)masterController team:(NSManagedObject *)team
{
    if((self = [super init])){
        self.masterController = masterController;
        self.team = team;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    if(self.team != nil) {
        self.name.text = [[self.team valueForKey:@"name"] description];
        self.uniformColor.text = [[self.team valueForKey:@"uniformColor"] description];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save
{
    if(self.masterController != nil){
        if(self.team != nil){
            [self.team setValue:self.name.text forKey:@"name"];
            [self.team setValue:self.uniformColor.text forKey:@"uniformColor"];
            [self.team setValue:[self.name.text substringToIndex:1] forKey:@"indexTitle"];
            [self.masterController saveContext];
        } else {
            [self.masterController insertTeamWithName:self.name.text uniformColor:self.uniformColor.text];
        }
    }
    
    [self.navigationController popToViewController:self.masterController animated:YES];
}

@end
