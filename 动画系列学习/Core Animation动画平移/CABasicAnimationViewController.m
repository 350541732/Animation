//
//  CABasicAnimationViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/18.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "CABasicAnimationViewController.h"

@interface CABasicAnimationViewController ()<CAAnimationDelegate>

@property(nonatomic,weak)CALayer *redLayer;

@end

@implementation CABasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
    
   /*
    self.redLayer = [self createLayerWithPosition:CGPointMake(100, 100) backgroundColor:[UIColor greenColor]];
    
    [self.redLayer addAnimation:[self createBasicAnimationWithFromValue:CGPointMake(10, 10) ToValue:CGPointMake(300, 400) timingFunction:kCAMediaTimingFunctionEaseOut] forKey:@"easeOut"];
    */
}
-(void)initUI
{
    CALayer *redLayer = [CALayer layer];
    redLayer.position = CGPointMake(200, 200);
    redLayer.bounds = CGRectMake(0, 0, 100, 100);
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:redLayer];
    self.redLayer = redLayer;
    
    //CABasicAnimation
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"position";
    basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    basicAnimation.duration = 2.0;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.delegate = self;
    
    [self.redLayer addAnimation:basicAnimation forKey:nil];
}
#pragma mark ---- Delegate
-(void)animationDidStart:(CAAnimation *)anim
{
//    self.redLayer.position = CGPointMake(300, 100);
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    self.redLayer.position = CGPointMake(300, 400);
    
    if (flag) {
        [self.redLayer removeAnimationForKey:@"easeOut"];
    }
}


#pragma mark ---Layer
-(CALayer *)createLayerWithPosition:(CGPoint)position backgroundColor:(UIColor *)backgroundColor
{
    CALayer *layer = [CALayer layer];
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = backgroundColor.CGColor;
    [self.view.layer addSublayer:layer];
    
    return layer;
}
#pragma mark ---basicAnimation
-(CABasicAnimation *)createBasicAnimationWithFromValue:(CGPoint)fromValue ToValue:(CGPoint)toValue timingFunction:(NSString *)timingFunction
{
    CABasicAnimation *basicAni = [CABasicAnimation animation];
    
    basicAni.keyPath = @"position";
    
    basicAni.fromValue = [NSValue valueWithCGPoint:fromValue];
    basicAni.toValue = [NSValue valueWithCGPoint:toValue];
    
    basicAni.duration = 2;
    basicAni.repeatCount = CGFLOAT_MAX;
    basicAni.delegate = self;
    
    basicAni.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    
    return basicAni;
}
@end
