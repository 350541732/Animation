//
//  SnowViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/23.
//  Copyright © 2019 LeeSin. All rights reserved.
//

#import "SnowViewController.h"

@interface SnowViewController ()

@property (nonatomic, weak) CAEmitterLayer *snowLayer;

@end

@implementation SnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupEmitter];
}

-(void)setupEmitter
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"tree"];
    
    //layer
    CAEmitterLayer *snowLayer = [CAEmitterLayer layer];
    [imageView.layer addSublayer:snowLayer];
    self.snowLayer = snowLayer;
    
    snowLayer.emitterShape = kCAEmitterLayerLine;
    snowLayer.emitterMode = kCAEmitterLayerVolume;
    snowLayer.emitterSize = self.view.frame.size;
    snowLayer.birthRate = 1.f;
    snowLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, -10);
    //自旋转速度
    snowLayer.spin = 1.f;
    //cell
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    snowCell.contents = (id)[UIImage imageNamed:@"snow_white"].CGImage;
    
    snowCell.birthRate = 1.f;
    snowCell.lifetime = 200.f;
    snowCell.speed = 10.f;
    
    snowCell.velocity = 2.f;
    snowCell.velocityRange = 10.f;
    snowCell.yAcceleration = 10.f;
    
    snowCell.emissionLongitude = M_PI_2;
    snowCell.emissionRange = M_PI_4;
    
    snowCell.spin = 1.f;
    snowCell.spinRange = 0.5f;
    
    snowLayer.emitterCells = @[snowCell];
}

@end
