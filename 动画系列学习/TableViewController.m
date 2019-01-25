//
//  TableViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/18.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "TableViewController.h"
#import "ClockController.h"
#import "CABasicAnimationViewController.h"
#import "CABasicAnimationScaleAndRotationViewController.h"
#import "CABAsicGroupViewController.h"
#import "LoginViewController.h"
#import "CAKeyframeAnimationViewController.h"
#import "CAAnimationGroupViewController.h"
#import "CAKeyframeTwitterViewController.h"
#import "CAShapeLayerViewController.h"
#import "CAReplicatorViewController.h"
#import "CAEmitterLayerViewController.h"
#import "CAGradientLayerViewController.h"
#import "RollerCoasterViewController.h"
@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *titlesArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titlesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
    }
    cell.textLabel.text = self.titlesArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        ClockController *clock = [ClockController new];
        [self.navigationController pushViewController:clock animated:YES];
        
    }

    if (indexPath.row == 1) {
        CABasicAnimationViewController *basicVC = [CABasicAnimationViewController new];
        [self.navigationController pushViewController:basicVC animated:YES];
    }
    if (indexPath.row == 2) {
        CABasicAnimationScaleAndRotationViewController *scaleAndRotationVC = [CABasicAnimationScaleAndRotationViewController new];
        [self.navigationController pushViewController:scaleAndRotationVC animated:YES];
    }
    if (indexPath.row == 3) {
        CABAsicGroupViewController *groupVC = [CABAsicGroupViewController new];
        [self.navigationController pushViewController:groupVC animated:YES];
        
    }
    
    if(indexPath.row == 4) {
        LoginViewController *loginVC = [LoginViewController new];
        [self.navigationController pushViewController:loginVC animated:YES];
    }

    if (indexPath.row == 5) {
        CAKeyframeAnimationViewController *keyframeVC = [CAKeyframeAnimationViewController new];
        [self.navigationController pushViewController:keyframeVC animated:YES];
    }
    
    if (indexPath.row == 6) {
        CAKeyframeTwitterViewController *keyframeTwitter = [CAKeyframeTwitterViewController new];
        [self.navigationController pushViewController:keyframeTwitter animated:YES];
        
    }
    if (indexPath.row == 7) {
        CAAnimationGroupViewController *groupVC = [CAAnimationGroupViewController new];
        [self.navigationController pushViewController:groupVC animated:YES];
    }
    if(indexPath.row == 8) {
        CAShapeLayerViewController *shapeVC = [CAShapeLayerViewController new];
        [self.navigationController pushViewController:shapeVC animated:YES];
        
    }
    
    if(indexPath.row == 9) {
        CAReplicatorViewController *caReplicatorVC = [CAReplicatorViewController new];
        [self.navigationController pushViewController:caReplicatorVC animated:YES];
        
    }
    
    if(indexPath.row == 10) {
        CAEmitterLayerViewController *emitterVC = [CAEmitterLayerViewController new];
        [self.navigationController pushViewController:emitterVC animated:YES];
    }
    
    if (indexPath.row == 11) {
        CAGradientLayerViewController *gradientVC = [CAGradientLayerViewController new];
        [self.navigationController pushViewController:gradientVC animated:YES];
        
    }
    
    if(indexPath.row == 12) {
        RollerCoasterViewController *rollVC = [RollerCoasterViewController new];
        
        [self.navigationController pushViewController:rollVC animated:YES];
    }
}

-(NSMutableArray *)titlesArray
{
    if (!_titlesArray) {
        _titlesArray = [[NSMutableArray alloc]initWithObjects:@"时分秒的指针",@"Core Animation动画平移",@"Core Animation旋转缩放",@"动画组合",@"登录动画",@"CAKeyframeAnimation关键帧动画",@"CAKeyframe Twitter启动动画",@"CAAnimationGroup动画组",@"CAShapeLayer流量图",@"CAReplicator播放器指示条",@"CAEmitter动画",@"CAGrdientLayer颜色渐变",@"过山车动画", nil];
    }
    return _titlesArray;
}
@end
