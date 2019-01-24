//
//  PraiseEmitterButton.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/22.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "PraiseEmitterButton.h"

@interface PraiseEmitterButton()

@property (nonatomic, strong) CAEmitterLayer *explosionLayer;

@end
@implementation PraiseEmitterButton

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        
        [self explosionAni];
        
    }else {
        [self explosionAni];
        
        [self stopAnimation];
    }
}

-(void)drawRect:(CGRect)rect
{
    [self setUpExplosion];
    
}

-(void)setUpExplosion
{
    CAEmitterCell *explosionCell = [[CAEmitterCell alloc]init];
    
    explosionCell.name = @"explosion";
    
    explosionCell.alphaRange = 0.10;
    
    explosionCell.alphaSpeed = -0.1;
    
    explosionCell.lifetime = 0.7;
    
    explosionCell.lifetimeRange = 0.3;
    
    explosionCell.birthRate = 2500;
    
    explosionCell.velocity = 40.00;
    
    explosionCell.velocityRange = 10.00;
    
    explosionCell.scale = 0.03;
    
    explosionCell.scaleRange = 0.02;
    
    explosionCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"explosion"].CGImage);
    
    self.explosionLayer.emitterCells = @[explosionCell];
    
    [self.layer addSublayer:self.explosionLayer];
    
}

-(void)explosionAni
{
    
    CAKeyframeAnimation *keyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    if (self.selected) {
        keyframeAni.values = @[@1.5,@0.8,@1.0,@1.2,@1.0];
        keyframeAni.duration = 0.5;
        
        [self startAnimation];
        
    }else {
        keyframeAni.values = @[@0.5,@1.0];
        keyframeAni.duration = 0.5;
    }
    
    keyframeAni.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:keyframeAni forKey:@"transform.scale"];
}

-(void)startAnimation
{
    self.explosionLayer.beginTime = CACurrentMediaTime();
    self.explosionLayer.birthRate = 1;
    
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}

-(void)stopAnimation
{
    self.explosionLayer.birthRate = 0;
}

#pragma mark ----lazy
-(CAEmitterLayer *)explosionLayer
{
    if (!_explosionLayer) {
        
        _explosionLayer = [CAEmitterLayer layer];
        
        _explosionLayer.emitterShape = kCAEmitterLayerCircle;
        
        _explosionLayer.emitterMode = kCAEmitterLayerOutline;
        
        _explosionLayer.emitterSize = CGSizeMake(10, 0);
        
        _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
        
        _explosionLayer.masksToBounds = NO;
        
        _explosionLayer.birthRate = 0;
        
        _explosionLayer.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        
        _explosionLayer.zPosition = -1;
    }
    
    return _explosionLayer;
}
@end
