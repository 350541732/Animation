//
//  CAAnimationGroupViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/21.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "CAAnimationGroupViewController.h"

@interface CAAnimationGroupViewController ()

@property(nonatomic,weak)CALayer *orangeL;
@end

@implementation CAAnimationGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self animationWithGroup];
}

-(void)animationWithGroup
{
    CALayer *orangeLayer = [CALayer layer];
    orangeLayer.bounds = CGRectMake(0, 0, 100, 100);
//    orangeLayer.position = CGPointMake(100, 100);
    orangeLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:orangeLayer];
    self.orangeL = orangeLayer;
    
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    
    //rotation
    CABasicAnimation *basicRitation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicRitation.toValue = @(M_PI * 2);
    
    //scale
    CABasicAnimation *basicScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicScale.toValue = @(0.2);
    
    //path
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    keyframe.path = path.CGPath;
    keyframe.calculationMode = kCAAnimationPaced;
    keyframe.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    group.animations = @[basicRitation,basicScale,keyframe];
    group.repeatCount = CGFLOAT_MAX;
    group.duration = 5;
    
    [self.orangeL addAnimation:group forKey:nil];
}

@end
