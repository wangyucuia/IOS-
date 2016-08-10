//
//  IDVertification.m
//  IOS生成本地验证码
//
//  Created by 王玉翠 on 16/8/10.
//  Copyright © 2016年 王玉翠. All rights reserved.
/** 
 一、实现思路
 1、思路描述
 自定义一个view，继承自UIView
 在view中添加子控件textField，backgroundImageView，label
 将验证码/密码的内容绘制到label的指定区域（计算得到），所以label要自定义，在drawRect方法中绘制验证码
 使用一个属性secureTextEntry，来控制显示验证码（显示真实的数字）或密码（显示圆点）
 2、视图中的子控件
 textField：只负责弹出键盘，获取键盘输入的数据；不用于演示键盘输入的内容，实际是隐藏的
 backgroundImageView：显示实现分割效果的背景图片
 label：显示验证码或密码的内容
 */

#import "IDVertification.h"
#import "IDLable.h"

//密码和验证码的位数
#define KSecurityNumber 4

@interface IDVertification ()<UITextFieldDelegate>

//用于获取键盘输入的内容,实际不先
@property (nonatomic, strong) UITextField *textField;


//验证码/密码输入框的背景图片
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) IDLable *label;


@end


@implementation IDVertification

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置透明背景色 .保证IDVertification显示的frame为backgroundImageView的frame
        self.backgroundColor = [UIColor clearColor];
        //密码的位数
        self.numberOfVertificationCode = KSecurityNumber;
        self.textField = [[UITextField alloc] initWithFrame:self.bounds]
        ;
        self.textField.backgroundColor = [UIColor orangeColor];
        
        self.textField.hidden = YES;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.delegate = self;
        //将textField放在最后边
        [self insertSubview:self.textField atIndex:0];
        
        //添加用于显示密码的label
        self.label = [[IDLable alloc] initWithFrame:self.bounds];
      //  self.label.backgroundColor = [UIColor magentaColor];
        self.label.numberOfVertificationCode = self.numberOfVertificationCode;
        self.label.textColor = [UIColor clearColor];
        self.label.securityTextEntry = self.securityTextEntry;
        [self addSubview:self.label];
        
        
    }
    return self;
}



-(void)setBackgrousIageName:(NSString *)backgrousIageName{
    
    _backgroundImageView = _backgroundImageView;
    
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundImageView.image = [UIImage imageNamed:backgrousIageName];
    
    //将背景图片插入到label后边,避免遮住验证码/密码的显示
    [self insertSubview:self.backgroundImageView belowSubview:self.label];
    
    
}


-(void)setNumberOfVertificationCode:(NSInteger)numberOfVertificationCode{
    
    _numberOfVertificationCode = numberOfVertificationCode;
    self.label.numberOfVertificationCode = numberOfVertificationCode;
    
    
}


-(void)setSecurityTextEntry:(BOOL)securityTextEntry{
    
    _securityTextEntry = securityTextEntry;
    self.label.securityTextEntry = securityTextEntry;
    
}

//弹出键盘,并接收键盘输入的字符
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.textField becomeFirstResponder];
}

//接收键盘输入的字符
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //判断是不是'删除字符'
    if (string.length != 0) {//不是'删除'字符
        //判断验证码/密码的位数是否达到预定的位数
        if ([textField.text length] < self.numberOfVertificationCode) {
            
            self.label.text = [textField.text stringByAppendingString:string];
            self.verificationCode = self.label.text
            ;
            return  YES;
        }else{
            
            return  NO;
            
        }
    }else{
        
        self.label.text = [textField.text substringToIndex:textField.text.length - 1];
        self.verificationCode = self.label.text;
        return YES;
        
    }
    
    
    
}








@end
