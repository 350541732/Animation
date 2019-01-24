//
//  CABAsicGroupViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/18.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "CABAsicGroupViewController.h"

@interface CABAsicGroupViewController ()

@property (weak, nonatomic) IBOutlet UIView *greenV;
@property (weak, nonatomic) IBOutlet UIView *orangeV;
@property (weak, nonatomic) IBOutlet UIView *grayV;


@end

@implementation CABAsicGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    __weak typeof(self) weakSelf = self;
    
    //添加阻尼动画
    [UIView animateWithDuration:0.8 delay:0.2 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionTransitionNone animations:^{
        
        weakSelf.greenV.center = CGPointMake(weakSelf.view.bounds.size.width - weakSelf.greenV.center.x, weakSelf.greenV.center.y+30);
        
        weakSelf.orangeV.center = CGPointMake(weakSelf.view.bounds.size.width - weakSelf.orangeV.center.x, weakSelf.orangeV.center.y+30);
        
        CGRect frame = CGRectMake(weakSelf.grayV.frame.origin.x, weakSelf.grayV.frame.origin.y, weakSelf.grayV.bounds.size.width, 200);
        
        weakSelf.grayV.frame = frame;
        
        [weakSelf.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
