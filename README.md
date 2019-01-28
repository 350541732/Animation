# Animation
ios 动画学习


### 此文章参考自[非典型技术宅大大]()(https://www.jianshu.com/p/26a7ccbc55c4)以及[STzen 大大]()(https://www.jianshu.com/p/c54ffd7412e7)的两篇文章，代码也是参考其代码整理，侵删，强烈推荐大家阅读一下以上的文章，受益匪浅。
### 背景，开发需求中iOS动画我们可能或多或少的会遇到一些，但是不管是动画的复杂性（其实也并不是很复杂）还是自己的其他一些原因，一直没有尝试学习，感觉这是非常不可取的，因此，忙完手上的工作后，这一周的时间自己慢慢的学习了一下动画的一些内容，并和大家一起分享一下自己比较疑惑的一些地方。

### [demo查看]()(https://github.com/350541732/Animation/tree/master)

### 1关于CALayer的一些属性
效果
![](https://upload-images.jianshu.io/upload_images/3015045-f4d9ea1d9ffb23c0.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/300)

#### CALayer Overview
- CALayer类在概念上和UIView类似，同样也是一些被层级关系树管理的矩形块，同样也可以包含一些内容(像图片，文本或者背景色)，管理子图层的位置。它们有一些方法和属性用来做动画和变换。和UIView 最大的不同是CALayer不处理用户的交互。
- 对一些简单的需求来说，我们确实没必要处理CALayer，因为苹果已经通过UIView 的高级API间接地使得动画变得很简单。但是这种简单会不可避免地带来一些灵活.上的缺陷。如果你略微想在底层做一些改变，或者使用一些苹果没有在UIView 上实现的接口功能，这时除了介入Core Animation底层之外别无选择。
我们已经证实了图层不能像视图那样处理触摸事件，那么他能做哪些视图不能做的呢?这里有一些UIView没有暴露出来的CALayer的功能:
●阴影，圆角，带颜色的边框
●3D变换
●非矩形范围
●透明遮罩
●多级非线性动画

#### CALayer 属性(个人理解)
- contents  layer的内容，id类型。但是必须的是CGImage类型，否则得到的图层是空白的。
```
`//一下两种都可以（可以直接写，xcode会提示）
clockLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"clock"]().CGImage);

clockLayer.contents = (id)([UIImage imageNamed:@"clock"]().CGImage);
```
\`- position  类似于UIView的center（默认情况下，在图形默认的中心）

 - anchorPoint (锚点) 决定于positon的位置，我们可以通过anchorPoint决定position的位置。它的范围是（0，0） （1，1）。如下图![](https://upload-images.jianshu.io/upload_images/3015045-bdceb22ec861372a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/297)
- 在上面的钟表，我们就修改了它的anchorPoint。试想如果我们不去修改它的anchorPoint，那么他就会变成这个样子，
  ![https://upload-images.jianshu.io/upload_images/3015045-57ff07053fc19fe1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000][image-3]
- 部分代码如下（CGPointMake设为（0.5，0）或（0.5，1）效果是相同的 ，大家可以自己修改看一下）
```
`UIView *hourHandView = [\[UIView alloc]()init];
hourHandView.backgroundColor = [UIColor blackColor]();
hourHandView.bounds = CGRectMake(0, 0, 4, 50);
hourHandView.center = self.view.center;
hourHandView.layer.anchorPoint = CGPointMake(0.5, 1);
[self.view addSubview:hourHandView]();
self.hourHandView = hourHandView;
```
\`
#### Animation（图片来自网络）
![https://upload-images.jianshu.io/upload_images/3015045-0655ee4daee0aeb4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/567][image-4]

#### CABasicAnimation
![https://upload-images.jianshu.io/upload_images/3015045-24e269d2842177f1.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/300][image-5]

- An object that provides basic, single-keyframe animation capabilities for a layer property. 继承自 CAPropertyAnimation。我们可通过keyPath设置动画的一些属性。常用的keyPath(不用记，用到的时候自己看一下就好了)
- fromValue 初始状态 比如 `basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];`表示初始位置。
- toValue 结束状态 比如 `  basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];`表示结束位置。
- `CABasicAnimation算是CAKeyFrameAnimation的 特殊情况，即不考虑中间变换过程，只考虑起始点与目标点就可以了`

![3015045-17a5793c59a784db][image-6]

#### CAKeyframeAnimation关键帧动画
![https://upload-images.jianshu.io/upload_images/3015045-b5b5b3f27b79e052.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/300][image-7]

- 通过两种方式来实现动画 `@property(nullable, copy) NSArray *values;`和` @property(nullable) CGPathRef path;`
- `@property(nullable, copy) NSArray<NSNumber *> *keyTimes;`该 属性是一个数组，假设用以指定每个子路径(AB,BC,CD)的时间。如果你没有显式地对keyTimes进行设置，则系统会默认每条子路径的时间 为：ti=duration/(5-1)，即每条子路径的duration相等，都为duration的1\4。当然，我们也可以传个数组让物体快慢结 合。例如，你可以传入{0.0, 0.1,0.6,0.7,1.0}，其中首尾必须分别是0和1，因此tAB=0.1-0, tCB=0.6-0.1, tDC=0.7-0.6, tED=1-0.7.....
- `@property(nullable, copy) NSArray<CAMediaTimingFunction *> *timingFunctions;`用以指定时间函数，类似于运动的加速度

#### gif部分代码
```
`//values
-(void)animationWithValues
{
CALayer *orangeLayer = [CALayer layer]();
orangeLayer.bounds = CGRectMake(0, 0, 100, 100);
orangeLayer.position = CGPointMake(100, 200);
orangeLayer.backgroundColor = [UIColor orangeColor]().CGColor;
[self.view.layer addSublayer:orangeLayer]();

self.orangeLayer = orangeLayer;

CAKeyframeAnimation *keyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"]();
keyframeAni.values = @[@(-M_PI_4 / 5),@(M_PI_4 / 5),@(-M_PI_4 / 5)]();
keyframeAni.duration = 10;
keyframeAni.repeatCount = CGFLOAT_MAX;

[self.orangeLayer addAnimation:keyframeAni forKey:@"rotation"]();
}
//path
-(void)animationWithPath
{
CALayer *planeLayer = [CALayer layer]();
planeLayer.bounds = CGRectMake(0, 0, 100, 100);
planeLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"plane"]().CGImage);
[self.view.layer addSublayer:planeLayer]();
self.planLayer = planeLayer;
//shake
CAKeyframeAnimation *shakeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"]();
shakeAni.values = @[@(-M_PI_4 / 5),@(M_PI_4 / 5),@(-M_PI_4 / 5)]();
shakeAni.duration = 0.25;
shakeAni.repeatCount = CGFLOAT_MAX;//无限循环


//oval path
CAKeyframeAnimation *keyframePlaneAni = [CAKeyframeAnimation animationWithKeyPath:@"position"]();

UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 500)]();
keyframePlaneAni.path = path.CGPath;
keyframePlaneAni.duration = 3;
keyframePlaneAni.repeatCount = CGFLOAT_MAX;
keyframePlaneAni.calculationMode = kCAAnimationCubic;

[self.planLayer addAnimation:keyframePlaneAni forKey:nil]();
[self.planLayer addAnimation:shakeAni forKey:nil]();
}
```
\`





#### CAShapeLayer  Overview
- A layer that draws a cubic Bezier spline in its coordinate space.(在坐标系内绘制贝塞尔曲线)
-  `@property CGFloat strokeStart; strokeEnd`部分绘制开始值和结束值。（可以通过修改此值，处理类似实现进度条的动画）
- ` @property(nullable) CGPathRef path;`描绘的路径
- ` @property(nullable) CGColorRef fillColor;`填充路径的颜色
- ` @property(copy) CAShapeLayerFillRule fillRule; ` 填充路径的规则，它的值有两种，非零和奇偶。默认非零。
-  `@property(nullable) CGColorRef strokeColor;` 描边颜色。
- 继承自`CALayer`，一般和`UIBezierPath`配合使用。（使用的频率比较高）
- 其他属性请看文档

![https://upload-images.jianshu.io/upload_images/3015045-98602076e3b7f8f6.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/300][image-8]
#### 进度条部分代码
```
`- (IBAction)animationClick:(UIButton *)sender {

    if (self.timer) {
    [self.timer fire]();
    }
    else {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(progressShowNumber) userInfo:nil repeats:YES]();
    }

}

-(void)progressShowNumber
{

if ([self getExpectValue]() \> self.progressValue) {
self.progressValue += 1;
self.circleProgressLayer.strokeEnd = self.progressValue /100.0;
CGFloat end = self.circleProgressLayer.strokeEnd;
self.progressLabel.text = [NSString stringWithFormat:@"%.1f%@",end * 100,@"%"]();

if ([self getExpectValue]() == self.progressValue) {

[self.timer invalidate]();
self.progressValue = [self getExpectValue]();
self.timer = nil;

}
}
else if ([self getExpectValue]() \< self.progressValue) {

self.progressValue -= 1;
self.circleProgressLayer.strokeEnd = self.progressValue / 100.0;
CGFloat end = self.circleProgressLayer.strokeEnd;
self.progressLabel.text = [NSString stringWithFormat:@"%.1f%@",end * 100,@"%"]();

if ([self getExpectValue]() == self.progressValue) {

[self.timer invalidate]();
self.progressValue = [self getExpectValue]();
self.timer = nil;
}
}
}
-(CAShapeLayer *)circleProgressLayer
{
if (!_circleProgressLayer) {

_circleProgressLayer = [CAShapeLayer layer]();
_circleProgressLayer.bounds = CGRectMake(0, 0, 240, 240);
_circleProgressLayer.position = CGPointMake(240/2, 240/2);


UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(240/2, 240/2) radius:240/2-10 startAngle:0 endAngle:M_PI ]()* 2 clockwise:YES];

_circleProgressLayer.strokeStart = 0;
_circleProgressLayer.strokeEnd = 1;

_circleProgressLayer.path = path.CGPath;
_circleProgressLayer.lineWidth = 10;
_circleProgressLayer.strokeColor = [UIColor redColor]().CGColor;

_circleProgressLayer.fillColor = [UIColor clearColor]().CGColor;

}
return _circleProgressLayer;
}
```
\`\#### CAEmitterLayer,CAEmitterCell

![https://upload-images.jianshu.io/upload_images/3015045-4674ce5add89b79f.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/300][image-9]

![https://upload-images.jianshu.io/upload_images/3015045-9e112f8df409b5d1.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/300][image-10]

![https://upload-images.jianshu.io/upload_images/3015045-e694a95f46f05249.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/300][image-11]

```
`CAEmitterLayer
@property(nullable, copy) NSArray\<CAEmitterCell *\> *emitterCells; // 用来装粒子的数组
@property float birthRate; // 粒子产生系数，默认1.0
@property float lifetime; // 粒子的生命周期系数, 默认1.0
@property CGPoint emitterPosition; // 决定了粒子发射形状的中心点
@property CGFloat emitterZPosition;
@property CGSize emitterSize; // 发射源的尺寸大小
@property CGFloat emitterDepth;
@property(copy) NSString *emitterShape; // 发射源的形状
@property(copy) NSString *emitterMode; // 发射模式
@property(copy) NSString *renderMode; // 渲染模式
@property BOOL preservesDepth;
@property float velocity; // 粒子速度系数, 默认1.0
@property float scale; // 粒子的缩放比例系数, 默认1.0
@property float spin; // 粒子的自旋转速度系数, 默认1.0
@property unsigned int seed; // 随机数发生器
```
\`
```
`@property(nullable, copy) NSString *name; // 粒子名字， 默认为nil(但是可以利用name,通过keyPath设置其一些属性)
@property(getter=isEnabled) BOOL enabled; 
@property float birthRate; // 粒子的产生率，默认0
@property float lifetime; // 粒子的生命周期,以秒为单位。默认0
@property float lifetimeRange; // 粒子的生命周期的范围，以秒为单位。默认0
@property CGFloat emissionLatitude;// 指定纬度,纬度角代表了在x-z轴平面坐标系中与x轴之间的夹角，默认0: 
@property CGFloat emissionLongitude; // 指定经度,经度角代表了在x-y轴平面坐标系中与x轴之间的夹角，默认0:
@property CGFloat emissionRange; //发射角度范围,默认0，以锥形分布开的发射角度。角度用弧度制。粒子均匀分布在这个锥形范围内;
@property CGFloat velocity; // 速度和速度范围，两者默认0
@property CGFloat velocityRange;
@property CGFloat xAcceleration; // x,y,z方向上的加速度分量,三者默认都是0
@property CGFloat yAcceleration;
@property CGFloat zAcceleration;
@property CGFloat scale; // 缩放比例, 默认是1
@property CGFloat scaleRange; // 缩放比例范围,默认是0
@property CGFloat scaleSpeed; // 在生命周期内的缩放速度,默认是0
@property CGFloat spin; // 粒子的平均旋转速度，默认是0
@property CGFloat spinRange; // 自旋转角度范围，弧度制,默认是0
@property(nullable) CGColorRef color; // 粒子的颜色,默认白色
@property float redRange; // 粒子颜色red,green,blue,alpha能改变的范围,默认0
@property float greenRange;
@property float blueRange;
@property float alphaRange;
@property float redSpeed; // 粒子颜色red,green,blue,alpha在生命周期内的改变速度,默认都是0
@property float greenSpeed;
@property float blueSpeed;
@property float alphaSpeed;
@property(nullable, strong) id contents; // 粒子的内容，为CGImageRef的对象
@property CGRect contentsRect;
@property CGFloat contentsScale;
@property(copy) NSString *minificationFilter;
@property(copy) NSString *magnificationFilter;
@property float minificationFilterBias;
@property(nullable, copy) NSArray\<CAEmitterCell *\> *emitterCells; // 粒子里面的粒子
@property(nullable, copy) NSDictionary *style;
```
\`
### 这里重点讲一下关于emissionLongitude的理解：
emissionLongitude是指在xy坐标系中垂直方向与x轴之间的夹角。但是这个坐标系的和velocity（速度）的正负值是有关系的！！（希望由此研究的简友提出宝贵建议），当velocity值为正值时，那么他的坐标系是这样的
![https://upload-images.jianshu.io/upload_images/3015045-26f5e6fff6b0db62.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000][image-12]
当velocity值为负值时，他的坐标系是这样的，
![https://upload-images.jianshu.io/upload_images/3015045-ea788c0b564e3c4c.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000][image-13]

各位看官老爷可以在[demo]()(https://github.com/350541732/Animation/tree/master)的
如下代码修改看一下变化，欢迎大家一起交流

```
`///"LoveHeartViewController.h"

heartCell.velocity = -120.f;
heartCell.velocityRange = 60.f;
heartCell.yAcceleration = 20.f;

heartCell.emissionLongitude = M_PI_2;
heartCell.emissionRange = M_PI_2 * 0.55;

/* heartCell.velocity = -120.f;
heartCell.velocityRange = 60.f;
heartCell.yAcceleration = 20.f;

heartCell.emissionLongitude = 0;
heartCell.emissionLongitude = M_PI;
heartCell.emissionRange = M_PI_2 * 0.55;
*/
```
\`\### [demo查看]()(https://github.com/350541732/Animation/tree/master)



[image-1]:	/Users/liguicheng/Documents/1.png
[image-2]:	/Users/liguicheng/Documents/3015045-bdceb22ec861372a.png
[image-3]:	/Users/liguicheng/Documents/3015045-57ff07053fc19fe1.png
[image-4]:	/Users/liguicheng/Documents/831339-b143eab37d0ec973.png
[image-5]:	/Users/liguicheng/Documents/2.png
[image-6]:	/Users/liguicheng/Documents/3015045-17a5793c59a784db.png
[image-7]:	/Users/liguicheng/Desktop/4.png
[image-8]:	/Users/liguicheng/Desktop/3.png
[image-9]:	/Users/liguicheng/Desktop/5.png
[image-10]:	/Users/liguicheng/Desktop/6.png
[image-11]:	/Users/liguicheng/Desktop/7.png
[image-12]:	/Users/liguicheng/Desktop/WechatIMG6.png
[image-13]:	/Users/liguicheng/Desktop/WechatIMG7.jpeg