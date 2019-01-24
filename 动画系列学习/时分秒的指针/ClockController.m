//
//  ClockController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/18.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "ClockController.h"

@interface ClockController ()

@property (nonatomic, weak) UIView *secondHandView;
@property (nonatomic, weak) UIView *minuteHandView;
@property (nonatomic, weak) UIView *hourHandView;

@end

@implementation ClockController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
    
    
}
-(void)initUI
{
    CALayer *clockLayer = [CALayer layer];
    clockLayer.bounds = CGRectMake(0, 0, 150, 150);
    clockLayer.position = self.view.center;
    clockLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"clock"].CGImage);
    [self.view.layer addSublayer:clockLayer];
    //second
    UIView *secondHandView = [[UIView alloc]init];
    secondHandView.backgroundColor = [UIColor redColor];
    secondHandView.bounds = CGRectMake(0, 0, 1, 60);
    secondHandView.center = self.view.center;
    secondHandView.layer.anchorPoint = CGPointMake(0.5, 0);
    [self.view addSubview:secondHandView];
    self.secondHandView = secondHandView;
    //minute
    UIView *minuteHandView = [[UIView alloc]init];
    minuteHandView.backgroundColor = [UIColor blackColor];
    minuteHandView.bounds = CGRectMake(0, 0, 3, 60);
    minuteHandView.center = self.view.center;
    minuteHandView.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.view addSubview:minuteHandView];
    self.minuteHandView = minuteHandView;
    //hour
    UIView *hourHandView = [[UIView alloc]init];
    hourHandView.backgroundColor = [UIColor blackColor];
    hourHandView.bounds = CGRectMake(0, 0, 4, 50);
    hourHandView.center = self.view.center;
    hourHandView.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.view addSubview:hourHandView];
    self.hourHandView = hourHandView;
    
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
#pragma mark ---tick
-(void)tick
{
    NSTimeZone *tZone = [NSTimeZone localTimeZone];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [NSDate date];
    
    [calendar setTimeZone:tZone];
    
    NSDateComponents *currentTime = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute |  NSCalendarUnitHour | NSCalendarUnitTimeZone fromDate:date];
    
    CGFloat angle = (M_PI * 2 / 60) * currentTime.second;
    self.secondHandView.transform = CGAffineTransformMakeRotation(angle);
    
    CGFloat minuteAngle = (M_PI * 2 /60) * currentTime.minute;
    self.minuteHandView.transform = CGAffineTransformMakeRotation(minuteAngle);
    
    CGFloat hourAngle = (M_PI * 2 /60) * currentTime.hour;
    self.hourHandView.transform = CGAffineTransformMakeRotation(hourAngle);
    
}

@end
