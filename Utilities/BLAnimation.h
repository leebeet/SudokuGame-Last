//
//  BLAnimation.h
//  Sudoku
//
//  Created by ApplePerfect on 14-10-26.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _BLDirection {
    
    DirectionToLeft = 1,
    DirectionToRight = 2,
    DirectionToTop = 3,
    DirectionToBottom = 4
    
}BLDirection;

@interface BLAnimation : NSObject
- (void)FlyToDestinationAnimationWithObject:(UIControl *)controller
                                 withDestination:(CGPoint)destination;

- (void)scaleRotationAnimationWithObject:(UIView *)object;

- (void)pushAnimationWithView:(UIView *)view
                     WithDirection:(BLDirection )direction
                     WithOffsetValueInX:(NSInteger)valueX
                     WithOffsetValueInY:(NSInteger)valueY;
@end
