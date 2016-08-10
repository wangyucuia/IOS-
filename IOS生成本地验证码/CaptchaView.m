//
//  CaptchaView.m
//  IOS生成本地验证码
//
//  Created by 王玉翠 on 16/8/10.
//  Copyright © 2016年 王玉翠. All rights reserved.
//

#import "CaptchaView.h"

#define KRandomColor [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0]
#define KLineCount 6
#define KLineWidth 1.0
#define KCharCount 6
#define KFontSize  [UIFont systemFontOfSize:arc4random() % 5 + 15]



@implementation CaptchaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 5.0; //设置layer圆角半径
        self.layer.masksToBounds = YES;
        self.backgroundColor = KRandomColor;
        [self changeCaptcha];
        
    }
    return self;
}

#pragma mark ----更换验证码.得到更换验证码的字符串
-(void)changeCaptcha{
    
       self.changArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"我",@"饿",@"死",@"了",nil];
    
        //如果能确定最大需要的容量,使用initWithCapactiy:来设置,好处当元素个数不超过容量时,不需要重新分配内存
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:KCharCount];
    self.changString = [[NSMutableString alloc] initWithCapacity:KCharCount];
    //随机从数组里选取需要的字符,然后评价成一个字符串
    for (int i = 0; i < KCharCount; i++) {
        NSInteger index= arc4random() % ([self.changArray count] -1);
        getStr = [self.changArray objectAtIndex:index];
        self.changString = (NSMutableString *)[self.changString stringByAppendingString:getStr];
        
    }
    
   
    
    //2.从网络中获取字符串,然后把得到的字符串在本地绘制出来
   // self.changString = [NSMutableString stringWithString:@"我饿四了"
                //        ];
    
    
}

#pragma mark ---点击view时调用,因为当前类自身就是view,点击更换验证码可以直接写到这个方法里,不需要额外的添加收拾
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //点击更换验证码
    [self changeCaptcha];
    
    
    //setNeedsDisplay调用drawRect方法来实现Viewdd的绘制
    [self setNeedsDisplay];
    
}


#pragma mark- ---绘制界面,(1.view初始化后自动调用.2调用setNeedsDisplay方法时会自动调用)
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    self.backgroundColor = KRandomColor;
    NSString *text = [NSString stringWithFormat:@"%@",self.changString];
    CGSize csize = [@"S" sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:20]}];
    int width = rect.size.width / text.length - csize.width;
    int height = rect.size.height - csize.height;
    CGPoint point;
    
    //依次绘制每一个字符,可以设置显示的每个字符的字符大小,颜色和样式
    float px,py;
    for (int i = 0; i < text.length; i++) {
        
        px = arc4random() % width + rect.size.width / text.length * i;
        py = arc4random() % height;
        point = CGPointMake(px, py);
        UniChar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C",c];
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:KFontSize}];
        
    }
    
    //调用drawRect:之前,系统会向栈中压入一个CGContextRef,调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置画线宽度
    CGContextSetLineWidth(context, KLineWidth);
    
    //绘制干扰的彩色直线
    for (int i = 0; i < KLineCount; i++) {
        //调用线的随机颜色
        UIColor *color = KRandomColor;
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        //设置线的起点
        px = arc4random() % (int)rect.size.width;
        py = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, px, py);
        //设置线终点
        px = arc4random() % (int)rect.size.width;
        py = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, px, py);
        //画线
        CGContextStrokePath(context);
        
        
    }
    
    
    
}



@end
