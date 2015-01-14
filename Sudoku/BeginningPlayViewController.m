//
//  BeginningPlayViewController.m
//  Sudoku
//
//  Created by beet on 10/16/14.
//  Copyright (c) 2014 Jan Lion. All rights reserved.
//

#import "BeginningPlayViewController.h"


@interface BeginningPlayViewController ()

@end

@implementation BeginningPlayViewController

+ (BeginningPlayViewController *)shareBeginningPlayViewController
{
    static BeginningPlayViewController *instance;
    if (instance == nil) {
        instance = [[BeginningPlayViewController alloc] init];
    }
    return instance;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BeginningButtonTapped:(id)sender {
    
    BLAnimation *anim = [[BLAnimation alloc] init];
    [anim pushAnimationWithView:self.homeView
                       WithDirection:DirectionToRight
                       WithOffsetValueInX: +196
                       WithOffsetValueInY:0];
    
    [anim pushAnimationWithView:self.settingDifficultyView
                       WithDirection:DirectionToLeft
                       WithOffsetValueInX:-196
                       WithOffsetValueInY:0];
}

- (IBAction)statisticsButtonTapped:(id)sender {
}

- (IBAction)SettingButtonTapped:(id)sender {
}

- (IBAction)helpingButtonTapped:(id)sender {
}

- (IBAction)aboutButtonTapped:(id)sender {
}

- (IBAction)difficultyButtonTapped:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    Sudoku *sudoku = [Sudoku sharedSudoku];
    if (button.tag == 200) {
        [sudoku initWithDifficulty:SudokuDifficultyEasy];
    }
    if (button.tag == 201) {
        [sudoku initWithDifficulty:SudokuDifficultyMiddle];
    }
    if (button.tag == 202) {
        [sudoku initWithDifficulty:SudokuDifficultyHard];
    }
    if (button.tag == 203) {
        [sudoku initWithDifficulty:SudokuDifficultyMaster];
    }
    
    BLAnimation *anim = [[BLAnimation alloc] init];
    [anim pushAnimationWithView:self.homeView
                       WithDirection:DirectionToLeft
                       WithOffsetValueInX:-196
                       WithOffsetValueInY:0];
    
    [anim pushAnimationWithView:self.settingDifficultyView
                       WithDirection:DirectionToRight
                       WithOffsetValueInX:196
                       WithOffsetValueInY:0];

}

@end
