# Animation
ios 动画学习

### 此文章参考自[非典型技术宅大大]()(https://www.jianshu.com/p/26a7ccbc55c4)以及[STzen 大大]()(https://www.jianshu.com/p/c54ffd7412e7)


效果（gif就不传了 太费劲了。。。。）：
![3.gif]()(https://upload-images.jianshu.io/upload_images/3015045-bc1f89837453d516.gif?imageMogr2/auto-orient/strip)
![81548333157_.pic_hd.jpg]()(https://upload-images.jianshu.io/upload_images/3015045-b9e528059ab4c741.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![91548333168_.pic_hd.jpg]()(https://upload-images.jianshu.io/upload_images/3015045-96167400f2b39a2b.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


> CAEmitterLayer,CAEmitterCell的属性解读


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
`
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
`
### 这里重点讲一下关于emissionLongitude的理解：
emissionLongitude是指在xy坐标系中垂直方向与x轴之间的夹角。但是这个坐标系的和velocity（速度）的正负值是有关系的！！（希望由此研究的简友提出宝贵建议），当velocity值为正值时，那么他的坐标系是这样的
![WechatIMG6.jpeg]()(https://upload-images.jianshu.io/upload_images/3015045-26f5e6fff6b0db62.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
当velocity值为负值时，他的坐标系是这样的，
![WechatIMG7.jpeg]()(https://upload-images.jianshu.io/upload_images/3015045-ea788c0b564e3c4c.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

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
`### 后续补上代码中关于一些其他动画的解释

