//
//  RollerCoasterViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/25.
//  Copyright © 2019 LeeSin. All rights reserved.
//

#import "RollerCoasterViewController.h"

#define K_SCREEN_HEIGHT      [UIScreen mainScreen].bounds.size.height
#define K_LAND_BEGIN_HEIGHT  K_SCREEN_HEIGHT - 20
#define K_SIZE               self.view.frame.size

@interface RollerCoasterViewController ()
//地面土地
@property (nonatomic, strong) CALayer *landLayer;
//绿色轨道
@property (nonatomic, strong) CAShapeLayer *greenTrack;
//黄色轨道
@property (nonatomic, strong) CAShapeLayer *yellowTrack;
@end

@implementation RollerCoasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initBackGroundSky];
    
    [self initSnowberg];
    
    [self initLawn];
    
    [self initLand];
    
    [self initYellowTrack];
    
    [self initGreenTrack];
    
    [self initTree];
    
    [self initCloudAnimation];
    
    [self carAnimationWith:@"car" TrackLayer:_yellowTrack AnimationDurtion:8.0 BeginTime:CACurrentMediaTime() + 1];
    
    [self carAnimationWith:@"otherCar" TrackLayer:_greenTrack AnimationDurtion:5.0 BeginTime:CACurrentMediaTime()];
}

//sky
-(void)initBackGroundSky
{
    CAGradientLayer *backgroundLayer = [CAGradientLayer layer];
    //frame
    backgroundLayer.frame = CGRectMake(0, 0, K_SIZE.width, K_LAND_BEGIN_HEIGHT);
    //color
    UIColor *lightColor = [UIColor colorWithRed:40.0/ 255.0 green:150.0/255.0 blue:200.0/255.0 alpha:1.0];
    UIColor *darkColor = [UIColor colorWithRed:255.0 / 255.0 green:250.0/255.0 blue:250.0 / 255.0 alpha:1.0];
    
    backgroundLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)darkColor.CGColor];
    
    //start end
    backgroundLayer.startPoint = CGPointMake(0, 0);
    backgroundLayer.endPoint = CGPointMake(1, 1);
    
    [self.view.layer addSublayer:backgroundLayer];
    
}

//snow
-(void)initSnowberg
{
    //雪山主体
    CAShapeLayer *leftSnowberg = [CAShapeLayer layer];
    UIBezierPath *leftSnowbergPath = [UIBezierPath bezierPath];
    //path
    [leftSnowbergPath moveToPoint:CGPointMake(0, K_SIZE.height - 120)];
    [leftSnowbergPath addLineToPoint:CGPointMake(100, 100)];
    [leftSnowbergPath addLineToPoint:CGPointMake(K_SIZE.width / 2, K_LAND_BEGIN_HEIGHT)];
    [leftSnowbergPath addLineToPoint:CGPointMake(0, K_LAND_BEGIN_HEIGHT)];
    
    //close
    [leftSnowbergPath closePath];
    
    leftSnowberg.path = leftSnowbergPath.CGPath;
    leftSnowberg.fillColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:leftSnowberg];
    
    CAShapeLayer *leftSnowbergBody = [CAShapeLayer layer];
    UIBezierPath *leftSnowbergBodyPath = [UIBezierPath bezierPath];
    
    CGPoint startPoint = CGPointMake(0, K_SIZE.height - 120);
    CGPoint endPoint = CGPointMake(100, 100);
    CGPoint firstPoint = [self calculateWithXValue:20 startPoint:startPoint endPoint:endPoint];
    //path
    [leftSnowbergBodyPath moveToPoint:startPoint];
    [leftSnowbergBodyPath addLineToPoint:firstPoint];
    [leftSnowbergBodyPath addLineToPoint:CGPointMake(60, firstPoint.y)];
    [leftSnowbergBodyPath addLineToPoint:CGPointMake(100, firstPoint.y + 30)];
    [leftSnowbergBodyPath addLineToPoint:CGPointMake(140, firstPoint.y)];
    [leftSnowbergBodyPath addLineToPoint:CGPointMake(180, firstPoint.y - 20)];
    
    CGPoint secondPathPoint = [self calculateWithXValue:K_SIZE.width / 2 - 125 startPoint:endPoint endPoint:CGPointMake(K_SIZE.width / 2, K_LAND_BEGIN_HEIGHT)];
    [leftSnowbergBodyPath addLineToPoint:CGPointMake(secondPathPoint.x - 30, firstPoint.y)];
    [leftSnowbergBodyPath addLineToPoint:secondPathPoint];
    [leftSnowbergBodyPath addLineToPoint:CGPointMake(K_SIZE.width / 2, K_LAND_BEGIN_HEIGHT)];
    [leftSnowbergBodyPath addLineToPoint:CGPointMake(0, K_LAND_BEGIN_HEIGHT)];
    [leftSnowbergBodyPath closePath];
    
    leftSnowbergBody.path = leftSnowbergBodyPath.CGPath;
    UIColor *snowColor = [UIColor colorWithDisplayP3Red:139.0 /255.0 green:92.0 /255.0 blue:0.0 /255.0 alpha:1.0];
    leftSnowbergBody.fillColor = snowColor.CGColor;
    [self.view.layer addSublayer:leftSnowbergBody];
    
    //middle Snowberg
    CAShapeLayer *middleSnowberg = [CAShapeLayer layer];
    UIBezierPath *middleSnowbergPath = [UIBezierPath bezierPath];
    
    CGPoint middleStartPoint = CGPointMake(K_SIZE.width / 3, K_LAND_BEGIN_HEIGHT);
    CGPoint middleToPoint = CGPointMake(K_SIZE.width / 2, 200);
    CGPoint middleEndPoint = CGPointMake(K_SIZE.width / 1.2, K_LAND_BEGIN_HEIGHT);
    
    [middleSnowbergPath moveToPoint:middleStartPoint];
    [middleSnowbergPath addLineToPoint:middleToPoint];
    [middleSnowbergPath addLineToPoint:middleEndPoint];
    [middleSnowbergPath closePath];
    
    middleSnowberg.path = middleSnowbergPath.CGPath;
    middleSnowberg.fillColor = [UIColor whiteColor].CGColor;
    [self.view.layer insertSublayer:middleSnowberg above:leftSnowbergBody];
    

    //未被覆盖的部分
    CAShapeLayer *middleSnowbergBody = [CAShapeLayer layer];
    UIBezierPath *middleSnowbergBodyPath = [UIBezierPath bezierPath];
    
    CGPoint middleFirstPathPoint = [self calculateWithXValue:middleStartPoint.x + 70 startPoint:middleStartPoint endPoint:middleToPoint];
    
    [middleSnowbergBodyPath moveToPoint:middleStartPoint];
    [middleSnowbergBodyPath addLineToPoint:middleFirstPathPoint];
    [middleSnowbergBodyPath addLineToPoint:CGPointMake(middleFirstPathPoint.x + 20, middleFirstPathPoint.y)];
    [middleSnowbergBodyPath addLineToPoint:CGPointMake(middleFirstPathPoint.x + 50, middleFirstPathPoint.y + 30)];
    [middleSnowbergBodyPath addLineToPoint:CGPointMake(middleFirstPathPoint.x + 80, middleFirstPathPoint.y - 10)];
    [middleSnowbergBodyPath addLineToPoint:CGPointMake(middleFirstPathPoint.x + 120, middleFirstPathPoint.y + 20)];
    
    
    CGPoint middleSecondPathPoint = [self calculateWithXValue:middleEndPoint.x - 120 startPoint:middleToPoint endPoint:middleEndPoint];
    [middleSnowbergBodyPath addLineToPoint:CGPointMake(middleSecondPathPoint.x - 30, middleSecondPathPoint.y)];
    [middleSnowbergBodyPath addLineToPoint:middleSecondPathPoint];
    
    [middleSnowbergBodyPath addLineToPoint:middleEndPoint];
    
    [middleSnowbergBodyPath closePath];
    
    middleSnowbergBody.path = middleSnowbergBodyPath.CGPath;
    UIColor *middleSnowColor = [UIColor colorWithDisplayP3Red:125.0 /255.0 green:87.0 /255.0 blue:7.0 /255.0 alpha:1.0];
    middleSnowbergBody.fillColor = middleSnowColor.CGColor;
    [self.view.layer insertSublayer:middleSnowbergBody above:middleSnowberg];
    
    
}

-(void)initLawn
{
    //left
    CAShapeLayer *leftLawn = [CAShapeLayer layer];
    UIBezierPath *leftLawnPath = [UIBezierPath bezierPath];
    
    CGPoint leftStartPoint = CGPointMake(0, K_LAND_BEGIN_HEIGHT);
    [leftLawnPath moveToPoint:leftStartPoint];
    [leftLawnPath addLineToPoint:CGPointMake(0, K_SIZE.height - 100)];
    
    //bezier
    [leftLawnPath addQuadCurveToPoint:CGPointMake(K_SIZE.width / 3.0, K_LAND_BEGIN_HEIGHT) controlPoint:CGPointMake(K_SIZE.width / 5.0, K_SIZE.height - 100)];
    leftLawn.path = leftLawnPath.CGPath;
    leftLawn.fillColor = [UIColor colorWithDisplayP3Red:82.0 / 255.0 green:177.0 / 255.0 blue:52.0 / 255.0 alpha:1.0].CGColor;
    [self.view.layer addSublayer:leftLawn];
    //right
    CAShapeLayer *rightLawn = [CAShapeLayer layer];
    UIBezierPath *rightLawnPath = [UIBezierPath bezierPath];
    
    [rightLawnPath moveToPoint:leftStartPoint];
    [rightLawnPath addQuadCurveToPoint:CGPointMake(K_SIZE.width, K_SIZE.height - 80) controlPoint:CGPointMake(K_SIZE.width / 2, K_SIZE.height - 90)];
    [rightLawnPath addLineToPoint:CGPointMake(K_SIZE.width, K_LAND_BEGIN_HEIGHT)];
    
    rightLawn.path = rightLawnPath.CGPath;
    rightLawn.fillColor = [UIColor colorWithRed:92.0 / 255.0 green:195.0 / 255.0 blue:52.0 / 255.0 alpha:2.0].CGColor;
    [self.view.layer insertSublayer:rightLawn above:leftLawn];
    
}
//land
-(void)initLand
{
    _landLayer = [CALayer layer];
    _landLayer.frame = CGRectMake(0, K_LAND_BEGIN_HEIGHT, K_SIZE.width, 20);
    _landLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ground"]].CGColor;
    [self.view.layer addSublayer:_landLayer];
    
    
}
//yellowTrack
-(void)initYellowTrack
{
    _yellowTrack = [CAShapeLayer layer];
    _yellowTrack.lineWidth = 5;
    _yellowTrack.strokeColor = [UIColor colorWithDisplayP3Red:210.0/255.0 green:179.0/255.0 blue:54.0/255.0 alpha:1.0].CGColor;
    //left 三次贝塞尔曲线
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
    [trackPath moveToPoint:CGPointMake(0, K_SIZE.height - 60)];
    [trackPath addCurveToPoint:CGPointMake(K_SIZE.width / 1.5, K_SIZE.height / 2.0 - 20) controlPoint1:CGPointMake(K_SIZE.width / 6.0, K_SIZE.height - 200) controlPoint2:CGPointMake(K_SIZE.width / 3.0, K_SIZE.height + 50)];
    //right 二次贝塞尔曲线（可注释掉看一下效果）
    [trackPath addQuadCurveToPoint:CGPointMake(K_SIZE.width + 50, K_SIZE.height / 3.0) controlPoint:CGPointMake(K_SIZE.width - 100, 50)];
    
    [trackPath addLineToPoint:CGPointMake(K_SIZE.width + 10, K_SIZE.height + 10)];
    [trackPath addLineToPoint:CGPointMake(0, K_SIZE.height + 10)];
    
    _yellowTrack.fillColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]].CGColor;
    _yellowTrack.path = trackPath.CGPath;
    [self.view.layer insertSublayer:_yellowTrack below:_landLayer];
    
    //镂空的虚线
    CAShapeLayer *trackLine = [CAShapeLayer layer];
    trackLine.lineCap = kCALineCapRound;
    trackLine.strokeColor = [UIColor whiteColor].CGColor;
    
    trackLine.lineDashPattern = @[@1.0,@6.0];
    trackLine.lineWidth = 2;
    trackLine.fillColor = [UIColor clearColor].CGColor;
    trackLine.path = trackPath.CGPath;
    
    [_yellowTrack addSublayer:trackLine];
}
//greenTrack
-(void)initGreenTrack
{
    _greenTrack = [CAShapeLayer layer];
    _greenTrack.lineWidth = 5;
    _greenTrack.strokeColor = [UIColor colorWithDisplayP3Red:0.0 / 255.0 green:147.0 / 255.0 blue:163.0 /255.0  alpha:1.0].CGColor;
    //right
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(K_SIZE.width + 10, K_LAND_BEGIN_HEIGHT)];
    [path addLineToPoint:CGPointMake(K_SIZE.width + 10, K_SIZE.height - 70)];
    [path addQuadCurveToPoint:CGPointMake(K_SIZE.width / 1.5, K_SIZE.height - 70) controlPoint:CGPointMake(K_SIZE.width - 150, 200)];
    //圆
    [path addArcWithCenter:CGPointMake(K_SIZE.width / 1.6, K_SIZE.height - 140) radius:70 startAngle:M_PI_2 endAngle:2.5 * M_PI clockwise:YES];
    //left
    [path addCurveToPoint:CGPointMake(0, K_SIZE.height - 100) controlPoint1:CGPointMake(K_SIZE.width / 1.6 -60, K_SIZE.height - 60) controlPoint2:CGPointMake(150, K_SIZE.height / 2.3)];
    [path addLineToPoint:CGPointMake(-10, K_LAND_BEGIN_HEIGHT)];
    _greenTrack.path = path.CGPath;
    _greenTrack.fillColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green"]].CGColor;
    
    [self.view.layer addSublayer:_greenTrack];
    
    //镂空
    CAShapeLayer *trackLine = [CAShapeLayer layer];
    trackLine.lineCap = kCALineCapRound;
    trackLine.strokeColor = [UIColor whiteColor].CGColor;
    
    trackLine.lineDashPattern = @[@1.0,@6.0];
    trackLine.lineWidth = 2;
    trackLine.fillColor = [UIColor clearColor].CGColor;
    trackLine.path = path.CGPath;
    
    [_greenTrack addSublayer:trackLine];
}

-(void)initTree
{
    [self addTreesWithNumber:7 treeFrame:CGRectMake(0, K_LAND_BEGIN_HEIGHT - 20, 13, 23)];
    
    [self addTreesWithNumber:3 treeFrame:CGRectMake(0, K_LAND_BEGIN_HEIGHT - 70, 13, 23)];
    
    [self addTreesWithNumber:5 treeFrame:CGRectMake(0, K_LAND_BEGIN_HEIGHT - 90, 13, 23)];
}

-(void)addTreesWithNumber:(NSInteger)treesNumber treeFrame:(CGRect)frame
{
    UIImage *tree = [UIImage imageNamed:@"tree"];
    
    for(NSInteger i = 0;i<treesNumber+1;i++) {
        CALayer *treeLayer = [CALayer layer];
        treeLayer.contents = (id)(tree.CGImage);
        
        treeLayer.frame = CGRectMake(K_SIZE.width - 50 * i * (arc4random_uniform(4) + 1), frame.origin.y, frame.size.width, frame.size.height);
    }
}
//cloud
-(void)initCloudAnimation
{
    CALayer *cloud = [CALayer layer];
    cloud.contents = (id)[UIImage imageNamed:@"cloud"].CGImage;
    cloud.frame = CGRectMake(0, 0, 63, 20);
    [self.view.layer addSublayer:cloud];
    
    UIBezierPath *cloudPath = [UIBezierPath bezierPath];
    [cloudPath moveToPoint:CGPointMake(K_SIZE.width + 60, 50)];
    [cloudPath addLineToPoint:CGPointMake(-60, 50)];
    
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.path = cloudPath.CGPath;
    ani.duration = 30.f;
    ani.autoreverses = NO;
    ani.repeatCount = CGFLOAT_MAX;
    ani.calculationMode = kCAAnimationPaced;
    
    [cloud addAnimation:ani forKey:@"position"];
}

//过山车动画
-(CAKeyframeAnimation *)carAnimationWith:(NSString *)carImageName TrackLayer:(CAShapeLayer *)track AnimationDurtion:(CFTimeInterval)duration BeginTime:(CFTimeInterval)beginTime
{
    CALayer *car = [CALayer layer];
    car.frame = CGRectMake(0, 0, 22, 15);
    car.contents = (id)[UIImage imageNamed:carImageName].CGImage;
    
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.path = track.path;
    
    ani.duration = duration;
    ani.beginTime = beginTime;
    ani.autoreverses = NO;
    ani.repeatCount = CGFLOAT_MAX;
    ani.calculationMode = kCAAnimationPaced;
    ani.rotationMode = kCAAnimationRotateAuto;
    
    [track addSublayer:car];
    [car addAnimation:ani forKey:@"carAni"];
    
    return ani;
}
//根据起始点，算出指定的x在这条线段上对应的y。返回这个point。知道两点，根据两点坐标，求出两点连线的斜率。y=kx+b求出点坐标。
-(CGPoint)calculateWithXValue:(CGFloat)xvalue startPoint:(CGPoint)startPoint endPoint:(CGPoint)endpoint
{
    CGFloat k = (endpoint.y - startPoint.y) / (endpoint.x - startPoint.x);
    CGFloat b = startPoint.y - startPoint.x * k;
    CGFloat yvalue = k*xvalue + b;
    
    return CGPointMake(xvalue, yvalue);
}
@end
