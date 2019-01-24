//
//  CAShapeLayerViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/21.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *progressValueTF;

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (weak, nonatomic) IBOutlet UIView *progressView;

//大圆
@property (nonatomic, strong) CAShapeLayer *circleLayer;
//实际进度
@property (nonatomic, strong) CAShapeLayer *circleProgressLayer;
//记录上一次的进度值
@property(assign,nonatomic) CGFloat progressValue ;
//定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.circleProgressLayer.strokeEnd = 0;
    
    self.progressValue = 0.0;
    
    [self.progressView.layer addSublayer:self.circleLayer];
    [self.progressView.layer addSublayer:self.circleProgressLayer];
    
    self.progressLabel.text = @"0.00%";
}


- (IBAction)animationClick:(UIButton *)sender {
    
    if (self.timer) {
        [self.timer fire];
    }
    else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(progressShowNumber) userInfo:nil repeats:YES];
    }

}

-(void)progressShowNumber
{
    
    if ([self getExpectValue] > self.progressValue) {
        self.progressValue += 1;
        self.circleProgressLayer.strokeEnd = self.progressValue /100.0;
        CGFloat end = self.circleProgressLayer.strokeEnd;
        self.progressLabel.text = [NSString stringWithFormat:@"%.1f%@",end * 100,@"%"];

        if ([self getExpectValue] == self.progressValue) {

            [self.timer invalidate];
            self.progressValue = [self getExpectValue];
            self.timer = nil;

        }
    }
    else if ([self getExpectValue] < self.progressValue) {

        self.progressValue -= 1;
        self.circleProgressLayer.strokeEnd = self.progressValue / 100.0;
        CGFloat end = self.circleProgressLayer.strokeEnd;
        self.progressLabel.text = [NSString stringWithFormat:@"%.1f%@",end * 100,@"%"];

        if ([self getExpectValue] == self.progressValue) {

            [self.timer invalidate];
            self.progressValue = [self getExpectValue];
            self.timer = nil;
        }
    }
}

-(CGFloat)getExpectValue
{
    if (!_progressValueTF.text) {
        return 0;
    }
    NSNumber *number = [[NSNumberFormatter alloc] numberFromString:_progressValueTF.text];
    if (!number) {
        return 0;
    }
    else{
        if ([number floatValue] >= 0 && [number floatValue] <= 100) {
            return [number floatValue];
        }else{
            return 0;
        }
    }
    
    return 0;
}
#pragma mark ---lazy
-(CAShapeLayer *)circleLayer
{
    if (!_circleLayer) {
        
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.bounds = CGRectMake(0, 0, 240, 240);
        _circleLayer.position = CGPointMake(240/2, 240/2);
        
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 240-20, 240-20)];
        _circleLayer.path = path.CGPath;
        
        _circleLayer.lineWidth = 10;
        _circleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _circleLayer;
}

-(CAShapeLayer *)circleProgressLayer
{
    if (!_circleProgressLayer) {
        
        _circleProgressLayer = [CAShapeLayer layer];
        _circleProgressLayer.bounds = CGRectMake(0, 0, 240, 240);
        _circleProgressLayer.position = CGPointMake(240/2, 240/2);
        
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(240/2, 240/2) radius:240/2-10 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        _circleProgressLayer.strokeStart = 0;
        _circleProgressLayer.strokeEnd = 1;
        
        _circleProgressLayer.path = path.CGPath;
        _circleProgressLayer.lineWidth = 10;
        _circleProgressLayer.strokeColor = [UIColor redColor].CGColor;
        
        _circleProgressLayer.fillColor = [UIColor clearColor].CGColor;
        
    }
    return _circleProgressLayer;
}

-(NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(progressShowNumber) userInfo:nil repeats:YES];
    }
    return _timer;
}
@end
