//
//  Stack.h
//  Sudoku
//
//  Created by whunf on 14-10-8.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

@property (nonatomic, strong) NSMutableArray *pushItems;

- (void)push:(id)item;
- (id)pop;
- (BOOL)isEmpty:(NSMutableArray *)item;
- (NSInteger)size;

@end
