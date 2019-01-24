//
//  CAKeyframeTwitterViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/21.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "CAKeyframeTwitterViewController.h"

@interface CAKeyframeTwitterViewController ()

@property (nonatomic, strong) CALayer *maskLayer;

@property (nonatomic, strong) UIImageView *backgroundImageV;

@end

@implementation CAKeyframeTwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initMask];
}

-(void)initMask
{
    [self.view addSubview:self.backgroundImageV];
    
    self.maskLayer.position = self.view.center;
    
    self.backgroundImageV.layer.mask = self.maskLayer;
    
    [self.maskLayer addAnimation:[self maskAni] forKey:nil];
    
}
-(CAKeyframeAnimation *)maskAni
{
    //放大或者缩小视图，keypath使用bounds
    CAKeyframeAnimation *maskAni = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    maskAni.duration = 5;
    maskAni.beginTime = CACurrentMediaTime() + 0.5;
    
    //
    CGRect startRect = self.maskLayer.frame;
    
    CGRect tempRect = CGRectMake(0, 0, 300, 500);
    
    CGRect finalRect = CGRectMake(0, 0, 2000, 2000);
    
    maskAni.values = @[[NSValue valueWithCGRect:startRect],[NSValue valueWithCGRect:tempRect],[NSValue valueWithCGRect:finalRect]];
    
    maskAni.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]
                                ,[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    maskAni.removedOnCompletion = NO;
    
    maskAni.fillMode = kCAFillModeForwards;
    
    return maskAni;
}

#pragma mark -----lazy
-(CALayer *)maskLayer
{
    if (!_maskLayer) {
        _maskLayer = [[CALayer alloc]init];
        
        _maskLayer.bounds = CGRectMake(0, 0, 50, 50);
        _maskLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"five"].CGImage);
    }
    return _maskLayer;
}

-(UIImageView *)backgroundImageV
{
    if(!_backgroundImageV) {
        _backgroundImageV = [[UIImageView alloc]initWithFrame:self.view.frame];
        _backgroundImageV.image = [UIImage imageNamed:@"girl"];
    }
    return _backgroundImageV;
}
@end
