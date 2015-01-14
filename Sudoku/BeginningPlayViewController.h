//
//  BeginningPlayViewController.h
//  Sudoku
//
//  Created by beet on 10/16/14.
//  Copyright (c) 2014 Jan Lion. All rights reserved.
//

#import "RootViewController.h"
#import "Sudoku.h"
#import "BLAnimation.h"

@interface BeginningPlayViewController : RootViewController

@property (weak, nonatomic) IBOutlet UIView *settingDifficultyView;
@property (weak, nonatomic) IBOutlet UIView *homeView;

+ (BeginningPlayViewController *)shareBeginningPlayViewController;

@end
