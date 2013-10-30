//
//  CusromCellContent.m
//  LeagueManager
//
//  Created by Nikolay Shatilo on 23.10.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "CustomCellContent.h"

@interface CustomCellContent ()
{
    UILabel *textField;
    UILabel *detailField;
}

@end

@implementation CustomCellContent

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configuration];
    }
    return self;
}

- (void)configuration
{
    self.backgroundColor = [UIColor blueColor];
    
    textField = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 215, 15.0)];
    textField.backgroundColor = [UIColor redColor];
    textField.font = [UIFont systemFontOfSize:12.0];
    
    [self addSubview:textField];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (NSString *)title
{
    return textField.text;
}

- (void)setTitle:(NSString *)title
{
    textField.text = title;
}

@end
