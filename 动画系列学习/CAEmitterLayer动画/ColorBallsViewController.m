//
//  ColorBallsViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/23.
//  Copyright © 2019 LeeSin. All rights reserved.
//

#import "ColorBallsViewController.h"

@interface ColorBallsViewController ()

@property (nonatomic, strong) CAEmitterLayer *colorBallLayer;

@end

@implementation ColorBallsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupEmitter];
}

-(void)setupEmitter
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
    [self.view addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.text = @"轻点或拖动来改变发射源位置";
    label.textAlignment = NSTextAlignmentCenter;
    
    //layer
    CAEmitterLayer *colorBallLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:colorBallLayer];
    
    colorBallLayer.emitterSize = self.view.frame.size;
    colorBallLayer.emitterMode = kCAEmitterLayerPoints;
    colorBallLayer.emitterShape = kCAEmitterLayerPoint;
    colorBallLayer.emitterPosition = CGPointMake(self.view.bounds.size.width, 0.f);
    
    self.colorBallLayer = colorBallLayer;
    
    //cell
    CAEmitterCell *colorCell = [CAEmitterCell emitterCell];
    colorCell.name = @"colorCell";
    
    colorCell.birthRate = 10.f;
    colorCell.lifetime = 10.f;
    
    colorCell.velocity = 40.f;
    colorCell.velocityRange = 100.f;
    colorCell.yAcceleration = 15.f;
    
    colorCell.emissionLongitude = M_PI;
    colorCell.emissionRange = M_PI_4;
    
    colorCell.scale = 0.2;
    colorCell.scaleRange = 0.1;
    colorCell.scaleSpeed = 0.02;
    
    colorCell.contents = (id)[UIImage imageNamed:@"circle_white"].CGImage;
    colorCell.color = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.f].CGColor;
    colorCell.redRange = 1.f;
    colorCell.greenRange = 1.f;
    colorCell.blueRange = 1.f;
    colorCell.alphaRange = 0.8;
    colorCell.alphaSpeed = -0.1f;
    
    colorBallLayer.emitterCells = @[colorCell];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [self locationFromTouchEvent:event];
    [self setBallInPoint:point];
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [self locationFromTouchEvent:event];
    [self setBallInPoint:point];
    
}

#pragma mark ---private func

-(CGPoint)locationFromTouchEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    return [touch locationInView:self.view];
    
}

-(void)setBallInPoint:(CGPoint)position
{
    //KVC
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"emitterCells.colorCell.scale"];
    ani.fromValue = @0.2f;
    ani.toValue = @0.5f;
    ani.duration = 1.f;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //事务
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.colorBallLayer addAnimation:ani forKey:nil];
    
    //KVC设置emitterPosition
//    [self.colorBallLayer setValue:[NSValue valueWithCGPoint:position] forKey:@"emitterPosition"];
    self.colorBallLayer.emitterPosition = position;
    [CATransaction commit];
}
@end
