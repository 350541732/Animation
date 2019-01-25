//
//  CAGradientLayerViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/23.
//  Copyright © 2019 LeeSin. All rights reserved.
//

#import "CAGradientLayerViewController.h"

@interface CAGradientLayerViewController ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation CAGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.gradientLayer = [CAGradientLayer layer];
    
    [self setUpGradientLayer];
    
}


-(void)setUpGradientLayer
{
    self.gradientLayer.frame = self.view.bounds;
    
    //colors
    self.gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor greenColor].CGColor];
    
    //startPoint endPoint
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 1);
    
    //locations
    self.gradientLayer.locations = @[@0.1,@0.5,@0.7,@0.85];
    
    [self.view.layer addSublayer:self.gradientLayer];
    
}
@end
