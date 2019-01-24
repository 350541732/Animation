//
//  RedPacketViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/24.
//  Copyright © 2019 LeeSin. All rights reserved.
//

#import "RedPacketViewController.h"

@interface RedPacketViewController ()

@property (nonatomic, strong) CAEmitterLayer *redpacketLayer;

@end

@implementation RedPacketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setRedPacketRain];
    
   
}

-(void)setRedPacketRain
{
    //layer
    CAEmitterLayer *redpacketLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:redpacketLayer];
    self.redpacketLayer = redpacketLayer;
    
    redpacketLayer.emitterShape = kCAEmitterLayerLine;
    redpacketLayer.emitterMode = kCAEmitterLayerSurface;
    redpacketLayer.emitterSize = self.view.frame.size;
    redpacketLayer.emitterPosition = CGPointMake(self.view.frame.size.width * 0.5, -10);
    redpacketLayer.birthRate = 1.f;
    
    //cell
    CAEmitterCell *redpacketCell = [CAEmitterCell emitterCell];
    redpacketCell.contents = (id)[UIImage imageNamed:@"red_packet"].CGImage;
    
    redpacketCell.birthRate = 1.f;
    redpacketCell.lifetime = 20.f;
    
    redpacketCell.velocity = 8.f;
    redpacketCell.yAcceleration = 100.f;
    
    redpacketCell.scale = 0.5f;
    
    redpacketLayer.emitterCells = @[redpacketCell];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.redpacketLayer.birthRate = 1.f;
    //KVC
    [self.redpacketLayer setValue:@100.f forKeyPath:@"birthRate"];
}
@end
