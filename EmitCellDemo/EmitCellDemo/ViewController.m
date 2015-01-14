//
//  ViewController.m
//  EmitCellDemo
//
//  Created by whunf on 14/10/19.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *flyDragon;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    
    anim.values = @[(id)[UIImage imageNamed:@"tcm1"].CGImage,
                    (id)[UIImage imageNamed:@"tcm2"].CGImage,
                    (id)[UIImage imageNamed:@"tcm3"].CGImage,
                    (id)[UIImage imageNamed:@"tcm4"].CGImage,
                    (id)[UIImage imageNamed:@"tcm5"].CGImage,
                    (id)[UIImage imageNamed:@"tcm6"].CGImage,
                    (id)[UIImage imageNamed:@"tcm7"].CGImage];
    anim.duration = 1.2f;
    anim.repeatDuration = NSIntegerMax;
    
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    move.toValue = @(2 * M_PI);
    move.duration = 1.9f;
    move.repeatDuration = NSIntegerMax;
    //move.fromValue = @0;
    
    //[self.flyDragon.layer addAnimation:move forKey:nil];
    //[self.flyDragon.layer addAnimation:anim forKey:nil];
    
    // 粒子系统
    
    // 发射器
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    CGRect screen = [UIScreen mainScreen].applicationFrame;
    emitter.emitterPosition = CGPointMake(screen.size.width / 2, screen.size.height /2);
    emitter.emitterMode = kCAEmitterLayerPoints;
    emitter.emitterShape = kCAEmitterLayerCircle;
    //emitter.seed = (arc4random() % 100) + 20;
    
    // 粒子
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = (id)[UIImage imageNamed:@"flare4"].CGImage;
    cell.lifetime = 3.0f; // 粒子的生命周期
    cell.birthRate = 20; // 粒子的数量
    cell.velocity = 100;  // 粒子的速度
    cell.emissionRange = M_PI * 2;
    //cell.yAcceleration = -250;
    cell.greenRange = 3.0;
    cell.greenSpeed = 0.5;
    cell.redRange = 2.0f;
    cell.blueRange = 6.0f;
    cell.scaleSpeed = -0.4;
    //cell.spin = 2 * M_PI;
    
    emitter.emitterCells = @[cell];
    
    [self.view.layer addSublayer:emitter];
    
    [emitter addAnimation:move forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
