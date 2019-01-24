//
//  FireViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/24.
//  Copyright © 2019 LeeSin. All rights reserved.
//

#import "FireViewController.h"

@interface FireViewController ()

@property (nonatomic, strong) CAEmitterLayer *fireLayer;

@property (nonatomic, strong) CAEmitterLayer *smokeLayer;

@end

@implementation FireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupEmitter];
    
}

-(void)setupEmitter
{
    
    /**
     写这个的目的在于了解emissionLongitude的含义
     1.圆是从最右边的点开始（0或者2*M_PI）开始
     2.向下走为正 依次为M_PI_2  M_PI  M_PI_2*3  M_PI*2
     3.从0向上走则为负值 依次为 -M_PI_2  -M_PI_2  -3*M_PI_2
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:100 startAngle:0 endAngle:-M_PI_2 clockwise:NO];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.position = CGPointMake(100, 100);
    layer.path = path.CGPath;
    
    path.lineWidth = 5;
    layer.strokeColor = [UIColor redColor].CGColor;
    [path stroke];
    [self.view.layer addSublayer:layer];
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
    [self.view addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.text = @"点击来控制火焰高度";
    label.textAlignment = NSTextAlignmentCenter;
    

    //fire
    self.fireLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:self.fireLayer];
    self.fireLayer.emitterSize = CGSizeMake(100.f, 0);
    self.fireLayer.emitterMode = kCAEmitterLayerOutline;
    self.fireLayer.emitterShape = kCAEmitterLayerLine;
    self.fireLayer.renderMode = kCAEmitterLayerAdditive;
    self.fireLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height - 200);

    //fireCell
    CAEmitterCell *fireCell = [CAEmitterCell emitterCell];
    fireCell.name = @"fireCell";

    fireCell.birthRate = 450.f;
    fireCell.scaleSpeed = 0.5;
    fireCell.lifetime = 0.9f;
    fireCell.lifetimeRange = 0.3;

    fireCell.velocity = -80.f;
    fireCell.velocityRange = 30;
    fireCell.yAcceleration = -200;

    fireCell.emissionLongitude = M_PI;
    fireCell.emissionRange = 1.1;

    fireCell.color = [UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1].CGColor;
    fireCell.contents = (id)[UIImage imageNamed:@"fire_white"].CGImage;

    self.fireLayer.emitterCells = @[fireCell];
    
    
    //smoke
    self.smokeLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:self.smokeLayer];
    
    self.smokeLayer.renderMode = kCAEmitterLayerAdditive;
    self.smokeLayer.emitterMode = kCAEmitterLayerPoints;
    self.smokeLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height - 200);
    //smoke
    CAEmitterCell *smokeCell = [CAEmitterCell emitterCell];
    smokeCell.name = @"smokeCell";
    
    smokeCell.birthRate = 11.f;
    smokeCell.scale = 0.1;
    smokeCell.scaleSpeed = 0.7;
    smokeCell.lifetime = 3.6;
    
    smokeCell.velocity = 40.f;
    smokeCell.velocityRange = 20;
    smokeCell.yAcceleration = -160;
    
    smokeCell.emissionLongitude = -M_PI_2; //与x轴相交为90°
    smokeCell.emissionRange = M_PI_4; //围绕上面的垂直于x轴这个左右45°
    
    smokeCell.spin = 1;
    smokeCell.spinRange = 6;
    
    smokeCell.alphaSpeed = -0.12;
    smokeCell.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.27].CGColor;
    smokeCell.contents = (id)[UIImage imageNamed:@"smoke_white"].CGImage;
    
    self.smokeLayer.emitterCells = @[smokeCell];
   
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setFireAndSmokeHeight:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setFireAndSmokeHeight:event];
}

-(void)setFireAndSmokeHeight:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGFloat distanceToBottom = self.view.bounds.size.height - touchPoint.y;
    CGFloat per = distanceToBottom / self.view.bounds.size.height;
    
    [self setFireAndSmokeCount:per * 2];
}

/**
 *设置火花数量
 *ratio:比例系数 0-1
 */

-(void)setFireAndSmokeCount:(float)ratio
{
    NSLog(@"SSSSSSSSSS%f",ratio);
    
    [self.fireLayer setValue:@(ratio * 500.0) forKeyPath:@"emitterCells.fireCell.birthRate"];
    [self.fireLayer setValue:[NSNumber numberWithFloat:ratio] forKeyPath:@"emitterCells.fireCell.lifetime"];
    [self.fireLayer setValue:@(ratio * 0.5) forKeyPath:@"emitterCells.fireCell.lifetimeRange"];
    [self.fireLayer setValue:[NSValue valueWithCGPoint:CGPointMake(ratio * 50, 0)] forKeyPath:@"emitterCells.fireCell.emitterSize"];
    
    
    // 烟雾
    [self.smokeLayer setValue:@(ratio * 4) forKeyPath:@"emitterCells.smokeCell.lifetime"]; // 生命周期
    [self.smokeLayer setValue:(id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:ratio * 0.3] CGColor] forKeyPath:@"emitterCells.smokeCell.color"]; // 透明度
    
}
@end
