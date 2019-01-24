//
//  LoginViewController.m
//  动画系列学习
//
//  Created by 李桂盛 on 2019/1/18.
//  Copyright © 2019 李桂盛. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

//约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginCenterX;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.userNameCenterX.constant -= self.view.bounds.size.width;
    self.passwordCenterX.constant -= self.view.bounds.size.width;
    self.loginCenterX.constant -= self.view.bounds.size.width;
    
    //
    self.loginBtn.alpha = 0;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.loginBtn.alpha = 1.0;
    __weak typeof(self) weakSelf  = self;
    //userName
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakSelf.userNameCenterX.constant += weakSelf.view.bounds.size.width;
        
        [weakSelf.view layoutIfNeeded];
        
    } completion:nil];
    //password
    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        weakSelf.passwordCenterX.constant += weakSelf.view.bounds.size.width;
        [weakSelf.view layoutIfNeeded];

    } completion:nil];
    //btn
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        weakSelf.loginCenterX.constant += weakSelf.view.bounds.size.width;
        [weakSelf.view layoutIfNeeded];

    } completion:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

}
//状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//- (IBAction)loginBtnClick:(UIButton *)sender {
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    __weak typeof(self)weakSelf = self;
    //模拟登录失败
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionCurveLinear animations:^{
        
        weakSelf.loginBtn.bounds = CGRectMake(weakSelf.loginBtn.bounds.origin.x-20, weakSelf.loginBtn.bounds.origin.y, weakSelf.loginBtn.bounds.size.width, weakSelf.loginBtn.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        weakSelf.loginBtn.bounds = CGRectMake(weakSelf.loginBtn.bounds.origin.x+20, weakSelf.loginBtn.bounds.origin.y, weakSelf.loginBtn.bounds.size.width, weakSelf.loginBtn.bounds.size.height);
    }];

}

- (IBAction)click:(id)sender {
    __weak typeof(self)weakSelf = self;
    //模拟登录失败
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionCurveLinear animations:^{
        
        weakSelf.loginBtn.bounds = CGRectMake(weakSelf.loginBtn.bounds.origin.x-20, weakSelf.loginBtn.bounds.origin.y, weakSelf.loginBtn.bounds.size.width, weakSelf.loginBtn.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        weakSelf.loginBtn.bounds = CGRectMake(weakSelf.loginBtn.bounds.origin.x+20, weakSelf.loginBtn.bounds.origin.y, weakSelf.loginBtn.bounds.size.width, weakSelf.loginBtn.bounds.size.height);
    }];

}


@end
