//
//  ViewController.m
//  IOS生成本地验证码
//
//  Created by 王玉翠 on 16/8/10.
//  Copyright © 2016年 王玉翠. All rights reserved.
//

#import "ViewController.h"
#import "CaptchaView.h"
#import "IDVertification.h"
@interface ViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) CaptchaView *captchaView;

@property (nonatomic,strong) UITextField *input;

@property (nonatomic,strong) IDVertification *vertificationCodeInputView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // [self capthaView];
    
    
    [self drawSecurity];
    
}

#pragma mark ----绘制验证码

//绘制验证码
-(void)capthaView{
    
    _captchaView = [[CaptchaView alloc] initWithFrame:CGRectMake(20, 40, 150, 40)];
    [self.view addSubview:_captchaView];
    
    //提示文字
    //提示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(190, 40, 100, 40)];
    label.text = @"点击图片换验证码";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    //添加输入框
    _input = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 150, 40)];
    _input.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _input.layer.borderWidth = 2.0;
    _input.layer.cornerRadius = 5.0;
    _input.font = [UIFont systemFontOfSize:21];
    _input.placeholder = @"请输入验证码!";
    _input.clearButtonMode = UITextFieldViewModeWhileEditing;
    _input.backgroundColor = [UIColor clearColor];
    _input.textAlignment = NSTextAlignmentCenter;
    _input.returnKeyType = UIReturnKeyDone;
    _input.delegate = self;
    [self.view addSubview:_input];
 
    
    
}



#pragma mark 输入框协议中方法,点击return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //判断输入的是否为验证图片显示的验证码
    if ([_input.text isEqualToString:_captchaView.changString]) {
        //正确弹出警告款提示正确
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"恭喜您 ^o^" message:@"验证成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alview show];
    }
    else
    {
        //验证不匹配，验证码和输入框晃动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [_captchaView.layer addAnimation:anim forKey:nil];
        [_input.layer addAnimation:anim forKey:nil];
    }
    return YES;
}



#pragma ----密码的绘制
-(void)drawSecurity{
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.vertificationCodeInputView = [[IDVertification alloc] initWithFrame:CGRectMake(50, 250, 200, 45)];
    self.vertificationCodeInputView.backgrousIageName = @"dot";
    // 验证码（显示数字）
    self.vertificationCodeInputView.securityTextEntry = NO;
   // self.vertificationCodeInputView.securityTextEntry = YES;
    [self.view addSubview:self.vertificationCodeInputView];

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
