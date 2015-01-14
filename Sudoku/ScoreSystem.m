//
//  ScoreSystem.m
//  Sudoku
//
//  Created by beet on 11/9/14.
//  Copyright (c) 2014 Jan Lion. All rights reserved.
//

#import "ScoreSystem.h"

@implementation ScoreSystem

- (id)init
{
    if (self = [super init]) {
        self.score = 0;
    }
    return self;
}

- (void)finishOneNumberBonus
{
    self.score = self.score + 50;
}

- (void)finishGameBonus
{
    self.score = self.score +1000;
}

- (void)RedoPunish
{
    self.score = self.score - 100;
}
@end
