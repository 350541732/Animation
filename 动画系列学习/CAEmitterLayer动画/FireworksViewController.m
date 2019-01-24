//
//  FireworksViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/24.
//  Copyright © 2019 LeeSin. All rights reserved.
//

#import "FireworksViewController.h"

@interface FireworksViewController ()

@property (nonatomic, strong) CAEmitterLayer  *fireworksLayer;

@end

@implementation FireworksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupEmitterLayer];
    
}

-(void)setupEmitterLayer
{
    //layer
    self.fireworksLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:self.fireworksLayer];
    
    self.fireworksLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height);
    self.fireworksLayer.emitterSize = CGSizeMake(self.view.bounds.size.width * 0.1, 0);
    self.fireworksLayer.emitterMode = kCAEmitterLayerOutline;
    self.fireworksLayer.emitterShape = kCAEmitterLayerLine;
    self.fireworksLayer.renderMode = kCAEmitterLayerAdditive;
    
    //shootCell
    CAEmitterCell *shootCell = [CAEmitterCell emitterCell];
    
    shootCell.birthRate = 1.0;
    shootCell.lifetime = 1.05;
    
    shootCell.velocity = 600.0;
    shootCell.velocityRange = 100.0;
    shootCell.yAcceleration = -76.0;
    
    shootCell.emissionRange = M_PI_4 / 2;
    
    shootCell.scale = 0.05;
    shootCell.color = [UIColor redColor].CGColor;
    shootCell.redRange = 1.0;
    shootCell.greenRange = 1.0;
    shootCell.blueRange = 1.0;
    
    shootCell.contents = (id)[UIImage imageNamed:@"shoot_white"].CGImage;
    shootCell.spinRange = M_PI * 2;
    
    
    //boomCell
    CAEmitterCell *boomCell = [CAEmitterCell emitterCell];
    boomCell.name = @"boomCell";
    
    boomCell.birthRate = 1.0;
    boomCell.lifetime = 0.5;
    boomCell.velocity = 0.0;
    boomCell.scale = 2.5;
    boomCell.redSpeed = -1.5;
    boomCell.blueRange = 1.5;
    boomCell.greenRange = 1.0;
    
    //sparkCell
    CAEmitterCell *sparkCell = [CAEmitterCell emitterCell];
    sparkCell.name = @"sparkCell";
    
    sparkCell.birthRate = 400;
    sparkCell.lifetime = 3.0;
    sparkCell.velocity = 125.0;
    sparkCell.yAcceleration = 75;
    sparkCell.emissionRange = M_PI * 2;
    
    sparkCell.scale = 1.2;
    sparkCell.contents = (id)[UIImage imageNamed:@"star_white_stroke"].CGImage;
    sparkCell.redSpeed = 0.4;
    sparkCell.greenSpeed = -0.1;
    sparkCell.blueSpeed = -0.1;
    sparkCell.alphaSpeed = -0.25;
    
    sparkCell.spin = M_PI * 2;
    
    //add
    self.fireworksLayer.emitterCells = @[shootCell];
    shootCell.emitterCells = @[boomCell];
    boomCell.emitterCells = @[sparkCell];
    
}


@end
