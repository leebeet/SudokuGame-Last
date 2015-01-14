//
//  Sudoku.m
//  Sudoku
//
//  Created by whunf on 14-10-8.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "Sudoku.h"
#define is0 [NSNumber numberWithInt:0]

@implementation Sudoku

+ (Sudoku *)sharedSudoku
{
    static Sudoku *instance = nil;
    if (instance == nil) {
        instance = [[Sudoku alloc] init];
    }
    return instance;
}
- (id)init
{
    if (self = [super init]) {
        self.numbers = [ @[ [@[@9, @8, @5,   @7, @6, @2,   @1, @3, @4] mutableCopy],
                            [@[@2, @6, @7,   @1, @3, @4,   @5, @8, @9] mutableCopy],
                            [@[@3, @1, @4,   @8, @9, @5,   @7, @6, @2] mutableCopy],
                            
                            [@[@8, @3, @2,   @9, @7, @6,   @4, @5, @1] mutableCopy],
                            [@[@1, @7, @6,   @4, @5, @3,   @2, @9, @8] mutableCopy],
                            [@[@5, @4, @9,   @2, @1, @8,   @6, @7, @3] mutableCopy],
                            
                            [@[@6, @2, @1,   @3, @8, @7,   @9, @4, @5] mutableCopy],
                            [@[@4, @5, @3,   @6, @2, @9,   @8, @1, @7] mutableCopy],
                            [@[@7, @9, @8,   @5, @4, @1,   @3, @2, @6] mutableCopy] ] mutableCopy];
        
 self.successNumbers = [ @[ [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                            [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                            [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                        
                            [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                            [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                            [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                            
                            [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                            [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                            [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy] ] mutableCopy];
    }
    return self;
}

- (BOOL)isCanPlace
{
    return YES;
}

- (CGPoint)randomUsedPosition
{
    return CGPointMake(arc4random()%9, arc4random()%9);
}

- (NSInteger)randomNumber
{
    NSInteger randomNumber = arc4random()%9;
    return randomNumber;
}

- (void)createCompleteChessboard
{
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {

            CGPoint usedPos = [self randomUsedPosition];
            NSInteger number = i + 1;
            SudokuNumber sudokuNumber;
            sudokuNumber.number = number;
            sudokuNumber.pos = usedPos;

            if (/*[self isCanPlace] && */[self isLegalWithSudokuNumber:sudokuNumber]) {
                [self placeSudokuNumber:sudokuNumber];
                [self printCurrentChessboard];
                [self createCompleteChessboard];
                [self printCurrentChessboard];
                
            }
            else {
                self.numbers[(NSInteger)sudokuNumber.pos.x][(NSInteger)sudokuNumber.pos.y] = @0;
            }
        }
    }
    for (int i = 0; i < 9; i++) {
        CGPoint usedPos = [self randomUsedPosition];
        NSInteger number = i + 1;
        SudokuNumber sudokuNumber;
        sudokuNumber.number = number;
        sudokuNumber.pos = usedPos;

    }
}

#pragma mark - Basic operation methods

- (void)initWithDifficulty:(SudokuDifficulty)difficulty
{
    NSInteger Blanks = 0;
    if (difficulty == SudokuDifficultyEasy)   Blanks = 1;
    if (difficulty == SudokuDifficultyMiddle) Blanks = 30;
    if (difficulty == SudokuDifficultyHard)   Blanks = 45;
    if (difficulty == SudokuDifficultyMaster) Blanks = 64;
    
    for (NSInteger count = 0; count < Blanks; count++) {
        NSInteger randomX = arc4random()%9 ;
        NSInteger randomY = arc4random()%9 ;
        if ([self.numbers[randomX][randomY]  isEqual: is0]) {
            count--;
        }
        self.numbers[randomX][randomY] = is0;
    }
        NSLog(@"set blank OK!");
    
}

- (BOOL)isLegalWithSudokuNumber:(SudokuNumber)sudokuNumber
{
    //行判断
    for (int i = 0; i < 9; i++) {
        if (i != sudokuNumber.pos.y) {

            if (sudokuNumber.number == [self.numbers[(NSInteger)sudokuNumber.pos.x][i] intValue]){
                return NO;
                NSLog(@"row number is wrong %@", self.numbers[(NSInteger)sudokuNumber.pos.x][i]);}
        }
    }
    //列判断
    for (int i = 0; i < 9; i++) {
        if (i != sudokuNumber.pos.x) {
            
            if (sudokuNumber.number == [self.numbers[i][(NSInteger)sudokuNumber.pos.y] intValue]) {
                return NO;
                NSLog(@"colum number is wrong %@", self.numbers[i][(NSInteger)sudokuNumber.pos.y]);
            }
        }
    }
    //9*9小数独盘判断
    NSInteger cY = (int)sudokuNumber.pos.y / 3 * 3 + 1;
    NSInteger cX = (int)sudokuNumber.pos.x / 3 * 3 + 1;
    for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
            if(((cX + i) == sudokuNumber.pos.x && (cY + j) == sudokuNumber.pos.y) != 0){
                if (sudokuNumber.number == [self.numbers[cX + i][cY + j] integerValue]){
                    return NO;
                    NSLog(@"9*9 cell number is wrong %@ ", self.numbers[cX + i][cY + j]);}
                }
            }
        }
    return YES;

}

- (void)placeSudokuNumber:(SudokuNumber)sudokuNumber
{
    self.numbers[(NSInteger)sudokuNumber.pos.x][(NSInteger)sudokuNumber.pos.y] = [NSNumber numberWithInteger:sudokuNumber.number] ;
}

- (BOOL)ifFinishGame
{
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9 ; j++) {
            if ([self.numbers[i][j] isEqual: is0]) {
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark - Testing methods

- (void)initChessboard
{

    self.successNumbers = [ @[ [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                               [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                               [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                               
                               [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                               [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                               [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                               
                               [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                               [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy],
                               [@[@0, @0, @0,   @0, @0, @0,   @0, @0, @0] mutableCopy] ] mutableCopy];

    
}

- (void)stepChessboardWithPosition:(CGPoint)pos
{

}

- (void)printCurrentChessboard
{
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            printf(" %d", [self.numbers[i][j] intValue]);
        }
        printf("\n");
    }
   // NSLog(@" The current chessboard is: %@", self.numbers);
}
- (NSArray *)highlightSelectedNumberWith:(NSNumber *)number
{
    NSMutableArray *array;
    
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (self.numbers[i][j] == number) {
                [array addObject: self.numbers[i][j]];
            }
        }
    }
    return array;
}

- (BOOL)isSuccessWithSudokuNumber:(SudokuNumber)sudokuNumber
{
    NSInteger columFlag = 0;
    NSInteger rowFlag = 0;
    NSInteger cellFlag = 0;
    NSInteger cY = (int)sudokuNumber.pos.y / 3 * 3 + 1;
    NSInteger cX = (int)sudokuNumber.pos.x / 3 * 3 + 1;
    
    //行判断
    for (int i = 0; i < 9; i++) {
            
        if ([self.numbers[(NSInteger)sudokuNumber.pos.x][i] intValue] != 0)     columFlag++;
        
    }
    //列判断
    for (int i = 0; i < 9; i++) {
            
            if ([self.numbers[i][(NSInteger)sudokuNumber.pos.y] intValue] != 0) rowFlag++;
        
    }
    //9*9小数独盘判断
    for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
            if ([self.numbers[cX + i][cY + j] intValue] != 0) {
                cellFlag++;
//                NSLog(@"--------cell flag : %d--------number: %@, pos: cX + i = %d, cY + j = %d, cX = %d, cY = %d", cellFlag,self.numbers[cX + i][cY + j], cX+i, cY+j,cX,cY);
//                NSLog(@"sudoku posx:%f, posy: %f", sudokuNumber.pos.x, sudokuNumber.pos.y);
            }
        }
    }
    if (columFlag == 9) {
        for (int i = 0; i < 9; i++) {
            self.successNumbers[(NSInteger)sudokuNumber.pos.x][i] = [NSNumber numberWithInt:1];//self.numbers[(NSInteger)sudokuNumber.pos.x][i];
        }
    }
    if (rowFlag == 9) {
        //列判断
        for (int i = 0; i < 9; i++) {
            self.successNumbers[i][(NSInteger)sudokuNumber.pos.y] = [NSNumber numberWithInt:1];//self.numbers[i][(NSInteger)sudokuNumber.pos.y];
        }
    }
    if (cellFlag == 9) {
        for (int i = -1; i < 2; i++) {
            for (int j = -1; j < 2; j++) {
                self.successNumbers[cX + i][cY + j] = [NSNumber numberWithInt:1];//self.numbers[cX + i][cY + j];
            }
        }
    }
    if (columFlag == 9 || rowFlag == 9 || cellFlag == 9) {
        return YES;
    }
    else return NO;
    
}


@end
