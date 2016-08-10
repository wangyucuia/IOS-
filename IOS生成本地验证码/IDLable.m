//
//  IDLable.m
//  IOS生成本地验证码
//
//  Created by 王玉翠 on 16/8/10.
//  Copyright © 2016年 王玉翠. All rights reserved.
//

#import "IDLable.h"

@implementation IDLable


-(void)setText:(NSString *)text{
    
    
    [super setText:text];
    
    //收到调用都让drawRect
    [self setNeedsDisplay];

}


//-(void)setTextColor:(UIColor *)textColor{
//    
//    [super setTextColor:textColor];
//
//}


//绘制验证码/密码

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    //计算每位验证码/密码的所在区域的宽和高
    float width = rect.size.width / (float)self.numberOfVertificationCode;;
    float height = rect.size.height;
    // 将每位验证码/密码绘制到指定区域
    for (int i = 0; i < self.text.length; i++) {
        // 计算每位验证码/密码的绘制区域
        CGRect tempRect = CGRectMake(i * width, 0, width, height);
        if (self.securityTextEntry) { // 密码，显示圆点
            UIImage *dotImage = [UIImage imageNamed:@"dot"];
            // 计算圆点的绘制区域
            CGPoint securityDotDrawStartPoint = CGPointMake(width * i + (width - dotImage.size.width) / 2.0, (tempRect.size.height - dotImage.size.height) / 2.0);
            // 绘制圆点
            [dotImage drawAtPoint:securityDotDrawStartPoint];
        } else { // 验证码，显示数字
            // 遍历验证码/密码的每个字符
            NSString *charecterString = [NSString stringWithFormat:@"%c", [self.text characterAtIndex:i]];
            // 设置验证码/密码的现实属性
            NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
            attributes[NSFontAttributeName] = self.font;
            // 计算每位验证码/密码的绘制起点（为了使验证码/密码位于tempRect的中部，不应该从tempRect的重点开始绘制）
            // 计算每位验证码/密码的在指定样式下的size
            CGSize characterSize = [charecterString sizeWithAttributes:attributes];
            CGPoint vertificationCodeDrawStartPoint = CGPointMake(width * i + (width - characterSize.width) / 2.0, (tempRect.size.height - characterSize.height) / 2.0);
            // 绘制验证码/密码
           [charecterString drawAtPoint:vertificationCodeDrawStartPoint withAttributes:attributes];
        }
    
    }
    
    
}

@end
