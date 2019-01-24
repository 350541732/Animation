//
//  CAReplicatorViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/22.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "CAReplicatorViewController.h"

@interface CAReplicatorViewController ()

@end

@implementation CAReplicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initCAReplicator];
    
}

-(void)initCAReplicator
{
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 100, 10, 80);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    [layer addAnimation:[self scaleAnimation] forKey:@"scaleAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [[CAReplicatorLayer alloc]init];
    replicatorLayer.frame = CGRectMake(0, 0, 80, 80);
    //复制层包含子层的个数
    replicatorLayer.instanceCount = 6;
    //设置子层相对于s前一层的b偏移
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    //设置子层相对于前一层的延迟时间
    replicatorLayer.instanceDelay = 0.2;
    //设置层的颜色，前提是要设置层的背景颜色，如果没有设置背景颜色，默认透明，在设置这个属性没有效果
    replicatorLayer.instanceColor = [UIColor greenColor].CGColor;
    //颜色渐变（RGB）
    replicatorLayer.instanceRedOffset = -0.2;
    replicatorLayer.instanceGreenOffset = -0.2;
    replicatorLayer.instanceBlueOffset = -0.2;
    
    [replicatorLayer addSublayer:layer];
    
    [self.view.layer addSublayer:replicatorLayer];
    
    ///second
    CALayer *secondLayer = [CALayer layer];
    secondLayer.frame = CGRectMake(0, 200, 10, 80);
    secondLayer.backgroundColor = [UIColor whiteColor].CGColor;
    secondLayer.anchorPoint = CGPointMake(0.5, 0.5);
    [secondLayer addAnimation:[self scaleAnimation] forKey:@"secondScaleAnimation"];
    
    CAReplicatorLayer *secondReplicatorLayer = [CAReplicatorLayer layer];
    secondReplicatorLayer.frame = CGRectMake(0, 100, 200, 80);
    
    secondReplicatorLayer.instanceCount = 20;
    secondReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(20, 20, 0);
    secondReplicatorLayer.instanceDelay = 0.05;
    secondReplicatorLayer.instanceColor = [UIColor orangeColor].CGColor;
    secondReplicatorLayer.instanceRedOffset = -0.2;
    secondReplicatorLayer.instanceGreenOffset = -0.2;
    secondReplicatorLayer.instanceBlueOffset = -0.2;
    
    [secondReplicatorLayer addSublayer:secondLayer];
    
    [self.view.layer addSublayer:secondReplicatorLayer];
    
    
}

-(CABasicAnimation *)scaleAnimation
{
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleAni.toValue = @0.1;
    scaleAni.duration = 0.4;
    scaleAni.autoreverses = YES;
    scaleAni.repeatCount = CGFLOAT_MAX;
    return scaleAni;
}
@end
