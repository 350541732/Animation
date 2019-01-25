//
//  LoveHeartViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/24.
//  Copyright © 2019 LeeSin. All rights reserved.
//

#import "LoveHeartViewController.h"

@interface LoveHeartViewController ()

@property (nonatomic, strong) CAEmitterLayer *heartLayer;

@end

@implementation LoveHeartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupEmitter];
    
}

-(void)setupEmitter
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
    [self.view addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.text = @"轻点屏幕以产生爱心";
    label.textAlignment = NSTextAlignmentCenter;
    
    //layer
    self.heartLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer: self.heartLayer];
    
    self.heartLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height -200);
    self.heartLayer.emitterShape = kCAEmitterLayerRectangle;
    self.heartLayer.emitterMode = kCAEmitterLayerVolume;
    self.heartLayer.renderMode = kCAEmitterLayerAdditive;
    self.heartLayer.emitterSize = CGSizeMake(100, 30);
    
    //cell
    CAEmitterCell *heartCell = [CAEmitterCell emitterCell];
    heartCell.name = @"heartCell";
    
    heartCell.birthRate = 0.f;
    heartCell.lifetime = 10.f; //生命周期
    
//    heartCell.velocity = -120.f;
//    heartCell.velocityRange = 60.f;
//    heartCell.yAcceleration = 20.f;
//
//    heartCell.emissionLongitude = M_PI_2;
//    heartCell.emissionRange = M_PI_2 * 0.55;
    
    ///
    heartCell.velocity = -120.f;
    heartCell.velocityRange = 60.f;
    heartCell.yAcceleration = 20.f;
    
//    heartCell.emissionLongitude = 0;
    heartCell.emissionLongitude = M_PI;
//    heartCell.emissionRange = M_PI_2 * 0.55;
    
    
    
    
    
    
    
    
    
    
    
    heartCell.contents = (id)[UIImage imageNamed:@"love_red"].CGImage;
    heartCell.color = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5].CGColor;
    heartCell.redRange = 0.3;
    heartCell.greenRange = 0.3;
    heartCell.blueRange = 0.3;
    heartCell.alphaRange = -0.5 / heartCell.lifetime;
    
    heartCell.scale = 0.5;
    heartCell.scaleRange = 0.5;
    heartCell.spin = 10.f;     //default 1
    heartCell.spinRange = 2.0 * M_PI_2;
    
    self.heartLayer.emitterCells = @[heartCell];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CABasicAnimation *heartAni = [CABasicAnimation animationWithKeyPath:@"emitterCells.heartCell.birthRate"];
    heartAni.fromValue = @150.f;
    heartAni.toValue = @0.f;
    heartAni.duration = 5.f;
    heartAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.heartLayer addAnimation:heartAni forKey:@""];
}

@end
