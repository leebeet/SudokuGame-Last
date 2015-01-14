//
//  BLAnimation.m
//  Sudoku
//
//  Created by ApplePerfect on 14-10-26.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "BLAnimation.h"

@implementation BLAnimation

- (void)FlyToDestinationAnimationWithObject:(UIControl *)controller withDestination:(CGPoint)destination
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.toValue = [NSValue valueWithCGPoint:destination];
    anim.duration = 0.8f;
    anim.autoreverses = YES;
    [controller.layer addAnimation:anim forKey:@"pos"];

}
- (void)scaleRotationAnimationWithObject:(UIView *)object
{
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = @0;
    rotation.toValue = @(M_PI * 2);
    rotation.duration = 0.8f;
    rotation.delegate = self;
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @1;
    scale.toValue = @1.5;
    scale.duration = 0.8f;
    scale.delegate = self;
    scale.autoreverses = YES;
    
    [object.layer addAnimation:rotation forKey:@"rotation"];
    [object.layer addAnimation:scale forKey:@"scale"];
    //NSLog(@"rotation animation occur");

}

-(void)pushAnimationWithView:(UIView *)view WithDirection:(BLDirection )direction WithOffsetValueInX:(NSInteger)valueX WithOffsetValueInY:(NSInteger)valueY
{
    UIView *pushView = view;
    if (direction == DirectionToLeft) {//show view animation
        [UIView animateWithDuration:0.4
                              delay:0.1
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^(){
                             pushView.layer.affineTransform = CGAffineTransformTranslate(pushView.transform, valueX, valueY);
                             
                         }
                         completion:^(BOOL completion){}];
        
    }
    
    if (direction == DirectionToRight) {//hide view animation
        [UIView animateWithDuration:0.4
                              delay:0.1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^(){
                             pushView.layer.affineTransform = CGAffineTransformTranslate(pushView.transform, valueX,valueY);
                             
                         }
                         completion:^(BOOL completion){}];
        
    }
}

@end
