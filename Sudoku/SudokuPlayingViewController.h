//
//  SudokuPlayingViewController.h
//  Sudoku
//
//  Created by ApplePerfect on 14-10-12.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sudoku.h"
#import "RootViewController.h"
#import "BLAnimation.h"
#import "MZTimerLabel.h"
#import "Stack.h"
#import "ScoreSystem.h"

@interface SudokuPlayingViewController : RootViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *sudokuMatrix;
@property (strong , nonatomic) Sudoku *sudoku;
@property (weak, nonatomic) IBOutlet UIView *selectedFrame;
@property (assign, nonatomic) BOOL isSuccess;
@property (strong, nonatomic) MZTimerLabel *timer;
@property (strong, nonatomic) Stack *stack;
@property (strong, nonatomic) IBOutlet UIView *finishGameView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) ScoreSystem *score;

@end
