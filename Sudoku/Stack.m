//
//  Stack.m
//  Sudoku
//
//  Created by whunf on 14-10-8.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "Stack.h"



@implementation Stack



- (void)push:(id)item
{
    [self.pushItems addObject:item];
    NSLog(@"self.pushItems : %@", self.pushItems);
}

- (id)pop
{
    id item;
    item = [self.pushItems lastObject];
    [self.pushItems removeLastObject];
    return item;
}

- (BOOL)isEmpty:(NSMutableArray *)item
{
    if (item.count == 0) {
        return YES;
    }
    return NO;
}

@end
