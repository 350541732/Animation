//
//  CAEmitterLayerViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/22.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "CAEmitterLayerViewController.h"
#import "PraiseEmitterButton.h"
///VC
#import "RainViewController.h"
#import "SnowViewController.h"
#import "ColorBallsViewController.h"
#import "RedPacketViewController.h"
#import "LoveHeartViewController.h"
#import "FireViewController.h"
#import "FireworksViewController.h"
@interface CAEmitterLayerViewController ()

@property (nonatomic, strong) PraiseEmitterButton *button;

@end

@implementation CAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    
}

-(void)buttonClick:(PraiseEmitterButton *)sender
{
    [sender setSelected:!sender.selected];
    
}
-(PraiseEmitterButton *)button
{
    if (!_button) {
        
        _button = [PraiseEmitterButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(100, 100, 40, 40);
        [_button setImage:[UIImage imageNamed:@"parise"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"praiseH"] forState:UIControlStateSelected];
        
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

//xib
- (IBAction)xibButtonClick:(UIButton *)sender {
    if (sender.tag == 100) {
        RainViewController *rainVC = [RainViewController new];
        rainVC.title = @"下雨";
        [self.navigationController pushViewController:rainVC animated:YES];
        
    }
    if (sender.tag == 101){
        SnowViewController *snowVC = [SnowViewController new];
        snowVC.title = @"下 雪";
        [self.navigationController pushViewController:snowVC animated:YES];
        
    }
    
    if (sender.tag == 102) {
        RedPacketViewController *redpacketVC = [RedPacketViewController new];
        redpacketVC.title = @"红包雨";
        [self.navigationController pushViewController:redpacketVC animated:YES];
        
    }
    
    if (sender.tag == 103) {
        ColorBallsViewController *colorVC = [ColorBallsViewController new];
        colorVC.title = @"五彩球";
        [self.navigationController pushViewController:colorVC animated:YES];
        
    }
    
    if (sender.tag == 104) {
        LoveHeartViewController *loveVC = [LoveHeartViewController new];
        loveVC.title = @"爱心";
        [self.navigationController pushViewController:loveVC animated:YES];
        
    }
    
    if (sender.tag == 105) {
        FireViewController *fireVC = [FireViewController new];
        [self.navigationController pushViewController:fireVC animated:YES];
    }
    
    if (sender.tag == 106) {
        FireworksViewController *fireworkVC = [FireworksViewController new];
        [self.navigationController pushViewController:fireworkVC animated:YES];
        
    }
    
    
}

@end
