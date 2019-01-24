//
//  RainViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/23.
//  Copyright © 2019 LeeSin. All rights reserved.
//

#import "RainViewController.h"

@interface RainViewController ()

@property (nonatomic, strong) CAEmitterLayer *rainLayer;
@property(nonatomic,weak)UIImageView *imageView;

@end

@implementation RainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self setupEmitter];
    
}

-(void)setUpUI
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"tree"];
    self.imageView = imageView;
    
    // 下雨按钮
    UIButton * startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startBtn];
    startBtn.frame = CGRectMake(20, self.view.bounds.size.height - 60, 80, 40);
    startBtn.backgroundColor = [UIColor whiteColor];
    [startBtn setTitle:@"雨停了" forState:UIControlStateNormal];
    [startBtn setTitle:@"下雨" forState:UIControlStateSelected];
    [startBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [startBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 雨量按钮
    UIButton * rainBIgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rainBIgBtn];
    rainBIgBtn.tag = 100;
    rainBIgBtn.frame = CGRectMake(140, self.view.bounds.size.height - 60, 80, 40);
    rainBIgBtn.backgroundColor = [UIColor whiteColor];
    [rainBIgBtn setTitle:@"下大点" forState:UIControlStateNormal];
    [rainBIgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rainBIgBtn addTarget:self action:@selector(rainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rainSmallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rainSmallBtn];
    rainSmallBtn.tag = 200;
    rainSmallBtn.frame = CGRectMake(240, self.view.bounds.size.height - 60, 80, 40);
    rainSmallBtn.backgroundColor = [UIColor whiteColor];
    [rainSmallBtn setTitle:@"太大了" forState:UIControlStateNormal];
    [rainSmallBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rainSmallBtn addTarget:self action:@selector(rainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonClick:(UIButton *)sender
{
    if (!sender.selected) {
        
        sender.selected = !sender.selected;
        
        [self.rainLayer setValue:@0.f forKey:@"birthRate"];
    }
    else
    {
        sender.selected = !sender.selected;
        
        [self.rainLayer setValue:@1.f forKey:@"birthRate"];
        
    }
}

-(void)rainButtonClick:(UIButton *)sender
{
    NSInteger rate = 1;
    CGFloat scale = 0.05;
    
    if (sender.tag == 100) {
        if (self.rainLayer.birthRate < 30) {
            
            [self.rainLayer setValue:@(self.rainLayer.birthRate + rate) forKey:@"birthRate"];
            [self.rainLayer setValue:@(self.rainLayer.scale + scale) forKey:@"scale"];
            
        }
    }
    else if (sender.tag == 200) {
        if (self.rainLayer.birthRate > 1) {
            [self.rainLayer setValue:@(self.rainLayer.birthRate - rate) forKey:@"birthRate"];
            [self.rainLayer setValue:@(self.rainLayer.scale - scale) forKey:@"scale"];
            
        }
    }
}

-(void)setupEmitter
{
    //layer
    CAEmitterLayer *rainLayer = [CAEmitterLayer layer];
    [self.imageView.layer addSublayer:rainLayer];
    self.rainLayer = rainLayer;
    
    //发射源的形状
    rainLayer.emitterShape = kCAEmitterLayerCircle;
    //发射模式
    rainLayer.emitterMode = kCAEmitterLayerVolume;
    //发射源的size 原定了发射源的大小
    rainLayer.emitterSize = CGSizeMake(100, 100);
    //发射源的位置
    rainLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, 200);
    
    //cell
    CAEmitterCell *rainCell = [CAEmitterCell emitterCell];
    rainCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"rain"].CGImage);
    
    //每秒产生的粒子数
    rainCell.birthRate = 25.f;
    //粒子的生命周期
    rainCell.lifetime = 20.f;
    rainCell.speed = 10.f;
    
    rainCell.velocity = 10.f;
    rainCell.velocityRange = 10.f;
    rainCell.yAcceleration = 1000.f;
    
    rainCell.scale = 0.1;
    rainCell.scaleRange = 0.f;
    
    rainLayer.emitterCells = @[rainCell];
    
    
}
@end
