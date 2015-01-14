//
//  RootViewController.m
//  Sudoku
//
//  Created by whunf on 14-10-8.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 整个app的背景图, 导航条图片设置, 返回按钮
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphonestd-background-wood-x10.jpg"]];
    [self.view insertSubview:background atIndex:0];
    background.frame = CGRectMake(0, 0, 320, 568);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)backButtonTapped:(UIButton *)button
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}


@end
