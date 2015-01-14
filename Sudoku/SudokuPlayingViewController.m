//
//  SudokuPlayingViewController.m
//  Sudoku
//
//  Created by ApplePerfect on 14-10-12.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "SudokuPlayingViewController.h"
#import "BLAnimation.h"

@interface SudokuPlayingViewController ()

@property (nonatomic, assign) CGPoint selectedPos;
@property (nonatomic, assign) SudokuNumber selectedSudokuCell;
@property (nonatomic, strong) NSMutableArray *cellPosition;
@property (nonatomic, assign) NSInteger cX;
@property (nonatomic, assign) NSInteger cY;
@end

@implementation SudokuPlayingViewController

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
    self.sudoku = [Sudoku sharedSudoku];
    //[self.sudoku initChessboard:chessboard];
    self.timer = [[MZTimerLabel alloc] initWithFrame:CGRectMake(90, 52, self.view.frame.size.width, 40)];
    self.timer.timerType = MZTimerLabelTypeStopWatch;
    [self.view addSubview:self.timer];
    //do some styling, start gaming stop watch
    self.timer.timeLabel.backgroundColor = [UIColor clearColor];
    self.timer.timeLabel.font = [UIFont systemFontOfSize:28.0f];
    self.timer.timeLabel.textColor = [UIColor brownColor];
    self.timer.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.timer start];
    
    self.stack = [[Stack alloc] init];
    self.stack.pushItems = [[NSMutableArray alloc] init];
    
    //KVO
    self.score = [[ScoreSystem alloc] init];
    [self.score addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionOld context:nil];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",[self.score valueForKey:@"score"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  Action for operation method

- (IBAction)oneToNightButtonTapped:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSInteger placeNumber = 0;
    
    if (button.tag == 1) placeNumber = 1;
    if (button.tag == 2) placeNumber = 2;
    if (button.tag == 3) placeNumber = 3;
    if (button.tag == 4) placeNumber = 4;
    if (button.tag == 5) placeNumber = 5;
    if (button.tag == 6) placeNumber = 6;
    if (button.tag == 7) placeNumber = 7;
    if (button.tag == 8) placeNumber = 8;
    if (button.tag == 9) placeNumber = 9;
    
    [self setSudokuNumberWithPositionX:self.cX WithpositionY:self.cY WithNumber:placeNumber];
    BLAnimation *anim = [[BLAnimation alloc] init];
    [anim FlyToDestinationAnimationWithObject:button withDestination:self.selectedPos];
    
    if ([self.sudoku isLegalWithSudokuNumber:self.selectedSudokuCell]) {
        [self.sudoku placeSudokuNumber:self.selectedSudokuCell];
        [self.sudoku initChessboard];
        self.isSuccess = [self.sudoku isSuccessWithSudokuNumber:self.selectedSudokuCell];
        [self.score finishOneNumberBonus];
        //NSLog(@"success numbers matrix :%@", self.sudoku.successNumbers);
        //[self.sudoku printCurrentChessboard];
        [self.sudokuMatrix reloadData];
        }
    if ([self.sudoku ifFinishGame]) {
        [NSTimer scheduledTimerWithTimeInterval:1.2f target:self selector:@selector(delayAnimation) userInfo:nil repeats:NO];
        [self.timer pause];
        [self.score finishGameBonus];
    }
    
    [self.stack push:[self structureToNSValueWith:self.selectedSudokuCell]];
    NSLog(@"selected number:%@", NSStringFromCGPoint(self.selectedSudokuCell.pos));
    NSLog(@"value after pushing into stack :%@", self.stack.pushItems);
   
}

- (NSValue *)structureToNSValueWith:(SudokuNumber )number
{
    SudokuNumber Cnumber;
    Cnumber = number;
    
    NSValue *value = [NSValue valueWithBytes: &Cnumber objCType:@encode(SudokuNumber)];
    NSLog(@"value before pushing into stack:%@",value);
    
//    SudokuNumber number2;
//    [value getValue: &number2];
//    NSLog(@"number2 is %@", NSStringFromCGPoint(number2.pos));
    return value;

}



- (IBAction)redoButtonTapped:(id)sender {
    
    SudokuNumber number;
    NSLog(@"self.stack.pushItems : %@", self.stack.pushItems);
    if (![self.stack isEmpty:self.stack.pushItems]) {
        NSValue *value = [self.stack pop];
        number = [self nsValueToStructureWith:value];
        NSLog(@"-----redo number:%@", NSStringFromCGPoint(number.pos));
        
        self.sudoku.numbers[(NSInteger)number.pos.x][(NSInteger)number.pos.y] = [NSNumber numberWithInteger:0];
        [self.score RedoPunish];
        
        [self.sudokuMatrix reloadData];
    }
   
}

- (SudokuNumber)nsValueToStructureWith:(NSValue *)value
{
    SudokuNumber number;
    [value getValue:&number];
    return number;
}
- (IBAction)undoButtonTapped:(id)sender {
}

- (void)delayAnimation
{
    BLAnimation *anim = [[BLAnimation alloc] init];
    [anim pushAnimationWithView:self.finishGameView WithDirection:DirectionToLeft WithOffsetValueInX:-290 WithOffsetValueInY:0];
}
- (IBAction)backButtonTapped:(id)sender {
    
    [self.sudoku init];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 81;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIButton *button = (UIButton *)[cell viewWithTag:100];
    UIView *redView = (UIView *)[cell viewWithTag:200];
    UIView *greenView = (UIView *)[cell viewWithTag:300];
    
    NSInteger cX = indexPath.row / 9;
    NSInteger cY = indexPath.row % 9;
    
    [self fillSudokuNumber:button positionX:(NSInteger )cX positionY: (NSInteger )cY];
    
    if (self.sudoku.numbers[self.cX][self.cY] != [NSNumber numberWithInt:0]) {
        if (self.sudoku.numbers[self.cX][self.cY] == self.sudoku.numbers[cX][cY]) {
            [greenView setHidden:NO];
            [redView setHidden:YES];
        }
        else {
            [greenView setHidden:YES];
            [redView setHidden:YES];
        }
    }
    if (self.isSuccess) {
        if (self.sudoku.successNumbers[cX][cY] != [NSNumber numberWithInt:0] ) {
            BLAnimation *anim = [[BLAnimation alloc] init];
            [anim scaleRotationAnimationWithObject:cell];
        }
    }
    return cell;
}

#pragma mark - collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"cell in section,row:(%d, %d)", indexPath.section, indexPath.row);
    self.cX = indexPath.row / 9;
    self.cY = indexPath.row % 9;
    [self.sudoku initChessboard];
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    self.selectedPos = CGPointMake(cell.center.x +4.0, cell.center.y + 119.0);
    //NSLog(@"selectedpos:%@", NSStringFromCGPoint(self.selectedPos));
    
    if ([self.sudoku.numbers[self.cX][self.cY] isEqual: [NSNumber numberWithInt:0]]) {
        self.selectedFrame.center = self.selectedPos;
        self.selectedFrame.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"normal-highlightRed-x10"]];
    }
    else [self.sudokuMatrix reloadData];
}


#pragma mark - Sudoku Number set method
- (void)fillSudokuNumber:button positionX:(NSInteger)cX positionY: (NSInteger)cY
{
    
    if ([self.sudoku.numbers[cX][cY] isEqual: [NSNumber numberWithInt:0]]) {
        [button setImage:[UIImage imageNamed:@"normal-slot-x10@2x"] forState:UIControlStateNormal];
    }
    if ([self.sudoku.numbers[cX][cY] isEqual: [NSNumber numberWithInt:1]]) {
        [button setImage:[UIImage imageNamed:@"normal-tilette-1-x10@2x"] forState:UIControlStateNormal];
    }
    if ([self.sudoku.numbers[cX][cY] isEqual: [NSNumber numberWithInt:2]]) {
        [button setImage:[UIImage imageNamed:@"normal-tilette-2-x10@2x"] forState:UIControlStateNormal];
    }
    if ([self.sudoku.numbers[cX][cY] isEqual: [NSNumber numberWithInt:3]]) {
        [button setImage:[UIImage imageNamed:@"normal-tilette-3-x10@2x"] forState:UIControlStateNormal];
    }
    if ([self.sudoku.numbers[cX][cY] isEqual: [NSNumber numberWithInt:4]]) {
        [button setImage:[UIImage imageNamed:@"normal-tilette-4-x10@2x"] forState:UIControlStateNormal];
    }
    if ([self.sudoku.numbers[cX][cY] isEqual: [NSNumber numberWithInt:5]]) {
        [button setImage:[UIImage imageNamed:@"normal-tilette-5-x10@2x"] forState:UIControlStateNormal];
    }
    if ([self.sudoku.numbers[cX][cY] isEqual: [NSNumber numberWithInt:6]]) {
        [button setImage:[UIImage imageNamed:@"normal-tilette-6-x10@2x"] forState:UIControlStateNormal];
    }
    if ([self.sudoku.numbers[cX][cY] isEqual: [NSNumber numberWithInt:7]]) {
        [button setImage:[UIImage imageNamed:@"normal-tilette-7-x10@2x"] forState:UIControlStateNormal];
    }
    if ([self.sudoku.numbers[cX][cY] isEqual: [NSNumber numberWithInt:8]]) {
        [button setImage:[UIImage imageNamed:@"normal-tilette-8-x10@2x"] forState:UIControlStateNormal];
    }
    if ([self.sudoku.numbers[cX][cY] isEqual: [NSNumber numberWithInt:9]]) {
        [button setImage:[UIImage imageNamed:@"normal-tilette-9-x10@2x"] forState:UIControlStateNormal];
    }
    
}

- (void)setSudokuNumberWithPositionX:(NSInteger)cX WithpositionY:(NSInteger)cY WithNumber:(NSInteger)number
{
    SudokuNumber num;
    num.number = number;
    num.pos = CGPointMake(cX, cY);
    self.selectedSudokuCell = num;
    //NSLog(@"selectedsuducell is :%@", self.selectedSudokuCell);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"score"]) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%@",[self.score valueForKey:@"score"]];
        NSLog(@"score: %d", self.score.score);
    }
}

- (void)dealloc
{
    [self.score removeObserver:self forKeyPath:@"score"];
}


@end
