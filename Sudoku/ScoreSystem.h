//
//  ScoreSystem.h
//  Sudoku
//
//  Created by beet on 11/9/14.
//  Copyright (c) 2014 Jan Lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreSystem : NSObject

@property (nonatomic, assign) NSInteger score;

- (void)finishOneNumberBonus;
- (void)finishGameBonus;
- (void)RedoPunish;


@end
