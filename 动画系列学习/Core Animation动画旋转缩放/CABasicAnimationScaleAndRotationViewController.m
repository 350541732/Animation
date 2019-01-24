//
//  CABasicAnimationScaleAndRotationViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/18.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "CABasicAnimationScaleAndRotationViewController.h"

@interface CABasicAnimationScaleAndRotationViewController ()

@property(nonatomic,weak)CALayer *redLayer;
@property(nonatomic,weak)CALayer *blueLayer;
@property(nonatomic,weak)CALayer *grayLayer;
@property(nonatomic,weak)CALayer *greenLayer;

@property(nonatomic,weak)CALayer *redRotationLayer;
@property(nonatomic,weak)CALayer *blueRotationLayer;
@property(nonatomic,weak)CALayer *grayRotationLayer;
@property(nonatomic,weak)CALayer *greenRotationLayer;

@property(nonatomic,weak)CALayer *heartLayer;

@end

@implementation CABasicAnimationScaleAndRotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
   
}

-(void)initUI
{
    //red
    self.redLayer = [self createLayerWithPosition:CGPointMake(125, 150) backgroundColor:[UIColor redColor]];
    [self.redLayer addAnimation:[self createCABasicAnimationWithKeyPath:@"transform.scale.x" toValue:0.5] forKey:nil];
    //blue
    self.blueLayer = [self createLayerWithPosition:CGPointMake(125, 250) backgroundColor:[UIColor blueColor]];
    [self.blueLayer addAnimation:[self createCABasicAnimationWithKeyPath:@"transform.scale.y" toValue:0.5] forKey:nil];
    //gray
    self.grayLayer = [self createLayerWithPosition:CGPointMake(125, 350) backgroundColor:[UIColor grayColor]];
    [self.grayLayer addAnimation:[self createCABasicAnimationWithKeyPath:@"transform.scale.z" toValue:0.5] forKey:nil];
    //green
    self.greenLayer = [self createLayerWithPosition:CGPointMake(125, 450) backgroundColor:[UIColor greenColor]];
    [self.greenLayer addAnimation:[self createCABasicAnimationWithKeyPath:@"transform.scale" toValue:0.5] forKey: nil];
    
    ///Rotation
    //red
    self.redRotationLayer = [self createLayerWithPosition:CGPointMake(250, 150) backgroundColor:[UIColor redColor]];
    [self.redRotationLayer addAnimation:[self createCABasicAnimationWithKeyPath:@"transform.rotation.x" toValue:M_PI_4] forKey:nil];
    //blue
    self.blueRotationLayer = [self createLayerWithPosition:CGPointMake(250, 250) backgroundColor:[UIColor blueColor]];
    [self.blueRotationLayer addAnimation:[self createCABasicAnimationWithKeyPath:@"transform.rotation.y" toValue:M_PI_4] forKey:nil];
    //gray
    self.grayRotationLayer = [self createLayerWithPosition:CGPointMake(250, 350) backgroundColor:[UIColor grayColor]];
    [self.grayRotationLayer addAnimation:[self createCABasicAnimationWithKeyPath:@"transform.rotation.z" toValue:M_PI_4] forKey:nil];
    //green
    self.greenRotationLayer = [self createLayerWithPosition:CGPointMake(250, 450) backgroundColor:[UIColor greenColor]];
    [self.greenRotationLayer addAnimation:[self createCABasicAnimationWithKeyPath:@"transform.rotation" toValue:M_PI_4] forKey:nil];
    
    //    添加几个Label，为了让演示的时候看上去更加清晰
    [self createUILabelWithTitle:@"缩放" frame:CGRectMake(100, 80, 50, 20)];
    [self createUILabelWithTitle:@"旋转" frame:CGRectMake(250, 80, 50, 20)];
    [self createUILabelWithTitle:@"X轴" frame:CGRectMake(20, 125, 50, 20)];
    [self createUILabelWithTitle:@"Y轴" frame:CGRectMake(20, 225, 50, 20)];
    [self createUILabelWithTitle:@"Z轴" frame:CGRectMake(20, 325, 50, 20)];
    [self createUILabelWithTitle:@"XYZ轴" frame:CGRectMake(20, 425, 50, 20)];
    
    
    //heart
    self.heartLayer = [self createLayerWithPosition:CGPointMake(self.view.center.x, 600) backgroundColor:[UIColor whiteColor]];
    self.heartLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"heart"].CGImage);
    [self.heartLayer addAnimation:[self createCABasicAnimationWithKeyPath:@"transform.scale" toValue:0.5] forKey:nil];
}

-(CALayer *)createLayerWithPosition:(CGPoint)position backgroundColor:(UIColor *)backgroundColor
{
    CALayer *layer = [CALayer layer];
    
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    
    layer.backgroundColor = backgroundColor.CGColor;
    
    [self.view.layer addSublayer:layer];
    
    return layer;
    
}

-(CABasicAnimation *)createCABasicAnimationWithKeyPath:(NSString *)keyPath toValue:(CGFloat)toValue
{
    CABasicAnimation *scaleAni = [CABasicAnimation animation];
    
    scaleAni.keyPath = keyPath;
    
    scaleAni.toValue = @(toValue);
    scaleAni.duration = 2;
    scaleAni.repeatCount = CGFLOAT_MAX;
    
    return scaleAni;
}

-(void)createUILabelWithTitle:(NSString *)title frame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.frame = frame;
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:label];
    
}
@end
