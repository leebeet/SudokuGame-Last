//
//  RootStaticTableController.m
//  Sudoku
//
//  Created by whunf on 14-10-8.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "RootStaticTableController.h"

@interface RootStaticTableController ()

@end

@implementation RootStaticTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 整个app的背景图, 导航条图片设置, 返回按钮
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sth"]];
    [self.view addSubview:background];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
