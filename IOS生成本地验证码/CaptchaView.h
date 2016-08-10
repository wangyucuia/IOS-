//
//  CaptchaView.h
//  IOS生成本地验证码
//
//  Created by 王玉翠 on 16/8/10.
//  Copyright © 2016年 王玉翠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptchaView : UIView


@property (nonatomic, strong) NSArray *changArray;//字符素材数组


@property (nonatomic, strong) NSMutableString *changString;//验证码的字符串


@end
