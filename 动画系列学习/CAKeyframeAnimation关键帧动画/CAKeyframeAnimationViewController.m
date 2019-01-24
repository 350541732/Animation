//
//  CAKeyframeAnimationViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/21.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "CAKeyframeAnimationViewController.h"

@interface CAKeyframeAnimationViewController ()

@property(nonatomic,weak)CALayer  *orangeLayer;

@property(nonatomic,weak)CALayer *planLayer;
@end

@implementation CAKeyframeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self animationWithValues];
    
    [self animationWithPath];
    
}

//values
-(void)animationWithValues
{
    CALayer *orangeLayer = [CALayer layer];
    orangeLayer.bounds = CGRectMake(0, 0, 100, 100);
    orangeLayer.position = CGPointMake(100, 200);
    orangeLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:orangeLayer];
    
    self.orangeLayer = orangeLayer;
    
    CAKeyframeAnimation *keyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    keyframeAni.values = @[@(-M_PI_4 / 5),@(M_PI_4 / 5),@(-M_PI_4 / 5)];
    keyframeAni.duration = 10;
    keyframeAni.repeatCount = CGFLOAT_MAX;
    
    [self.orangeLayer addAnimation:keyframeAni forKey:@"rotation"];
}
//path
-(void)animationWithPath
{
    CALayer *planeLayer = [CALayer layer];
    planeLayer.bounds = CGRectMake(0, 0, 100, 100);
    planeLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"plane"].CGImage);
    [self.view.layer addSublayer:planeLayer];
    self.planLayer = planeLayer;
    //shake
    CAKeyframeAnimation *shakeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    shakeAni.values = @[@(-M_PI_4 / 5),@(M_PI_4 / 5),@(-M_PI_4 / 5)];
    shakeAni.duration = 0.25;
    shakeAni.repeatCount = CGFLOAT_MAX;
    
    
    //oval path
    CAKeyframeAnimation *keyframePlaneAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 500)];
    keyframePlaneAni.path = path.CGPath;
    keyframePlaneAni.duration = 3;
    keyframePlaneAni.repeatCount = CGFLOAT_MAX;
    keyframePlaneAni.calculationMode = kCAAnimationCubic;
    
    [self.planLayer addAnimation:keyframePlaneAni forKey:nil];
    [self.planLayer addAnimation:shakeAni forKey:nil];
}
@end
