//
//  ViewController.m
//  Sudoku
//
//  Created by whunf on 14-10-8.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *chessboard = [@[@[@5, @3, @0,   @0, @7, @0,   @0, @0, @0],
                             @[@6, @0, @0,   @1, @9, @5,   @0, @0, @0],
                             @[@0, @9, @8,   @0, @0, @0,   @0, @6, @0],
                             
                             @[@8, @0, @0,   @0, @6, @0,   @0, @0, @3],
                             @[@4, @0, @0,   @8, @0, @3,   @0, @0, @1],
                             @[@7, @0, @0,   @0, @2, @0,   @0, @0, @6],
                             
                             @[@0, @6, @0,   @0, @0, @0,   @2, @8, @0],
                             @[@0, @0, @0,   @4, @1, @9,   @0, @0, @5],
                             @[@0, @0, @0,   @0, @8, @0,   @0, @7, @9]] mutableCopy];

    
    Sudoku *sudoku = [[Sudoku alloc] init];
    //[sudoku initChessboard:chessboard];
    [sudoku printCurrentChessboard];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
