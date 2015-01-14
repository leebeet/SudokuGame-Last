//
//  Sudoku.h
//  Sudoku
//
//  Created by whunf on 14-10-8.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"

//const NSInteger Dimension = 9;

typedef enum _SudokuDifficulty {
    
    SudokuDifficultyEasy = 1,
    SudokuDifficultyMiddle = 2,
    SudokuDifficultyHard = 3,
    SudokuDifficultyMaster = 4
    
}SudokuDifficulty;

//typedef struct __Point{
//    int x;
//    int y;
//}NNPoint;

typedef struct _SudokuNumber {
    CGPoint pos;       // (row, colum)  9 X 9
    NSInteger number;  // 当前给定位置放置的数字
}SudokuNumber;

@interface Sudoku : NSObject

@property (nonatomic, strong) NSMutableArray *numbers; // NSString NSNumber
@property (nonatomic, strong) NSMutableArray *successNumbers;
@property (nonatomic, strong) Stack *undoStack;
@property (nonatomic, strong) Stack *redoStack;

/* ---------- 基础方法 ----------- */
- (void)initWithDifficulty:(SudokuDifficulty)difficulty;
- (BOOL)isLegalWithSudokuNumber:(SudokuNumber)sudokuNumber;
- (void)placeSudokuNumber:(SudokuNumber)sudokuNumber;
- (BOOL)ifFinishGame;
- (BOOL)isSuccessWithSudokuNumber:(SudokuNumber)sudokuNumber;

- (NSArray*)highlightSelectedNumberWith:(NSNumber *)number;

+ (Sudoku *)sharedSudoku;
/* ------------------------------ */



/* ---------- 测试方法 ----------- */
// 传参初始化布局, chessboard为初始化棋盘布局
- (void)initChessboard;

 // 放置给定pos位置的数字, pos为无数字空格位置
- (void)stepChessboardWithPosition:(CGPoint)pos;

// 打印当前棋盘布局
- (void)printCurrentChessboard;
/* ------------------------------ */



/* --------- 生成方法 ------------ */
// 创建一个完整的棋盘
- (void)createCompleteChessboard;

// 依据当前的棋盘布局找到完整棋盘
- (void)solveChessbaord;
/* ------------------------------ */


/* ---------- 进阶方法 ----------- */
- (void)redo;
- (void)undo;
- (void)hint;
/* ------------------------------ */

@end
