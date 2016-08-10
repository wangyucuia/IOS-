//
//  IDVertification.h
//  IOS生成本地验证码
//
//  Created by 王玉翠 on 16/8/10.
//  Copyright © 2016年 王玉翠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDVertification : UIView

//背景图片
@property (nonatomic, copy) NSString *backgrousIageName;

//验证码,密码的位数
@property (nonatomic, assign) NSInteger numberOfVertificationCode;
//控制验证码/密码是否密文显示
@property (nonatomic, assign) BOOL securityTextEntry;
//验证码.密码内容,可以通过该属性拿到验证码.密码输入框中验证码/密码的内容
@property (nonatomic, copy) NSString *verificationCode;



@end
