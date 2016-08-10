//
//  IDLable.h
//  IOS生成本地验证码
//
//  Created by 王玉翠 on 16/8/10.
//  Copyright © 2016年 王玉翠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDLable : UILabel

//验证码,密码的位数
@property (nonatomic, assign) NSInteger numberOfVertificationCode;

//密码是否明文输入
@property (nonatomic, assign) BOOL securityTextEntry;



@end
