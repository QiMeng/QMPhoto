//
//  M2Theme.m
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "M2Theme.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define HEX(c)       [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

@interface M2OneTheme : NSObject <M2Theme>
@end

@implementation M2OneTheme

+ (UIImage *)imageForLevel:(NSInteger)level
{
    NSString * imageStr = @"";
    
    switch (level) {
        case 1:
            imageStr = @"IMG_0092.JPG";
            break;
        case 2:
            imageStr = @"IMG_0092.JPG";
            break;
        case 3:
            imageStr = @"IMG_0092.JPG";
            break;
        case 4:
            imageStr = @"d4";
            break;
        case 5:
            imageStr = @"d5";
            break;
        case 6:
            imageStr = @"d6";
            break;
        case 7:
            imageStr = @"d7";
            break;
        case 8:
            imageStr = @"d8";
            break;
        case 9:
            imageStr = @"d9";
            break;
        case 10:
            imageStr = @"d10";
            break;
        case 11:
            imageStr = @"d11";
            break;
        case 12:
            imageStr = @"d12";
            break;
        case 13:
            imageStr = @"d13";
            break;
  
        case 15:
        default:
            imageStr = @"d1";
            break;
    }
    
    return [UIImage imageNamed:imageStr];
    
}


//等级颜色
+ (UIColor *)colorForLevel:(NSInteger)level
{
    switch (level) {
        case 1:
            return RGB(238, 228, 218);
        case 2:
            return RGB(237, 224, 200);
        case 3:
            return RGB(242, 177, 121);
        case 4:
            return RGB(245, 149, 99);
        case 5:
            return RGB(246, 124, 95);
        case 6:
            return RGB(246, 94, 59);
        case 7:
            return RGB(237, 207, 114);
        case 8:
            return RGB(237, 204, 97);
        case 9:
            return RGB(237, 200, 80);
        case 10:
            return RGB(237, 197, 63);
        case 11:
            return RGB(237, 194, 46);
        case 12:
            return RGB(173, 183, 119);
        case 13:
            return RGB(170, 183, 102);
        case 14:
            return RGB(164, 183, 79);
        case 15:
        default:
            return RGB(161, 183, 63);
    }
}

//等级字体颜色
+ (UIColor *)textColorForLevel:(NSInteger)level
{
    switch (level) {
        case 1:
        case 2:
            return RGB(118, 109, 100);
        default:
            return [UIColor whiteColor];
    }
}

//背景颜色
+ (UIColor *)backgroundColor
{
    return RGB(250, 248, 239);
}

//版的颜色
+ (UIColor *)boardColor
{
    return RGB(204, 192, 179);
}

//分数版的颜色
+ (UIColor *)scoreBoardColor
{
    return RGB(187, 173, 160);
}

//按钮颜色
+ (UIColor *)buttonColor
{
    return RGB(119, 110, 101);
}

//字体
+ (NSString *)boldFontName
{
    return @"AvenirNext-DemiBold";
}


+ (NSString *)regularFontName
{
    return @"AvenirNext-Regular";
}

@end

@interface M2TwoTheme : NSObject <M2Theme>
@end

@implementation M2TwoTheme

+ (UIImage *)imageForLevel:(NSInteger)level
{
    NSString * imageStr = @"";
    
    switch (level) {
        case 1:
            imageStr = @"b1";
            break;
        case 2:
            imageStr = @"b2";
            break;
        case 3:
            imageStr = @"b3";
            break;
        case 4:
            imageStr = @"b4";
            break;
        case 5:
            imageStr = @"b5";
            break;
        case 6:
            imageStr = @"b6";
            break;
        case 7:
            imageStr = @"b7";
            break;
        case 8:
            imageStr = @"b8";
            break;
        case 9:
            imageStr = @"b9";
            break;
        case 10:
            imageStr = @"b10";
            break;
        case 11:
            imageStr = @"b11";
            break;
        case 12:
            imageStr = @"b12";
            break;
        case 13:
            imageStr = @"b13";
            break;
        case 14:
            imageStr = @"b14";
            break;
        case 15:
        default:
            imageStr = @"b15";
            break;
    }
    
    return [UIImage imageNamed:imageStr];
    
}


//等级颜色
+ (UIColor *)colorForLevel:(NSInteger)level
{
    switch (level) {
        case 1:
            return RGB(238, 228, 218);
        case 2:
            return RGB(237, 224, 200);
        case 3:
            return RGB(242, 177, 121);
        case 4:
            return RGB(245, 149, 99);
        case 5:
            return RGB(246, 124, 95);
        case 6:
            return RGB(246, 94, 59);
        case 7:
            return RGB(237, 207, 114);
        case 8:
            return RGB(237, 204, 97);
        case 9:
            return RGB(237, 200, 80);
        case 10:
            return RGB(237, 197, 63);
        case 11:
            return RGB(237, 194, 46);
        case 12:
            return RGB(173, 183, 119);
        case 13:
            return RGB(170, 183, 102);
        case 14:
            return RGB(164, 183, 79);
        case 15:
        default:
            return RGB(161, 183, 63);
    }
}

//等级字体颜色
+ (UIColor *)textColorForLevel:(NSInteger)level
{
    switch (level) {
        case 1:
        case 2:
            return RGB(118, 109, 100);
        default:
            return [UIColor whiteColor];
    }
}

//背景颜色
+ (UIColor *)backgroundColor
{
    return RGB(250, 248, 239);
}

//版的颜色
+ (UIColor *)boardColor
{
    return RGB(204, 192, 179);
}

//分数版的颜色
+ (UIColor *)scoreBoardColor
{
    return RGB(187, 173, 160);
}

//按钮颜色
+ (UIColor *)buttonColor
{
    return RGB(119, 110, 101);
}

//字体
+ (NSString *)boldFontName
{
    return @"AvenirNext-DemiBold";
}


+ (NSString *)regularFontName
{
    return @"AvenirNext-Regular";
}

@end

@interface M2ThereTheme : NSObject <M2Theme>
@end

@implementation M2ThereTheme

+ (UIImage *)imageForLevel:(NSInteger)level
{
    NSString * imageStr = @"";
    
    switch (level) {
        case 1:
            imageStr = @"c1";
            break;
        case 2:
            imageStr = @"c2";
            break;
        case 3:
            imageStr = @"c3";
            break;
        case 4:
            imageStr = @"c4";
            break;
        case 5:
            imageStr = @"c5";
            break;
        case 6:
            imageStr = @"c6";
            break;
        case 7:
            imageStr = @"c7";
            break;
        case 8:
            imageStr = @"c8";
            break;
        case 9:
            imageStr = @"c9";
            break;
        case 10:
            imageStr = @"c10";
            break;
        case 11:
            imageStr = @"c11";
            break;
        case 12:
            imageStr = @"c12";
            break;
        case 13:
            imageStr = @"c13";
            break;
        case 14:
            imageStr = @"c14";
            break;
        case 15:
        default:
            imageStr = @"c15";
            break;
    }
    
    return [UIImage imageNamed:imageStr];
    
}


//等级颜色
+ (UIColor *)colorForLevel:(NSInteger)level
{
    switch (level) {
        case 1:
            return RGB(238, 228, 218);
        case 2:
            return RGB(237, 224, 200);
        case 3:
            return RGB(242, 177, 121);
        case 4:
            return RGB(245, 149, 99);
        case 5:
            return RGB(246, 124, 95);
        case 6:
            return RGB(246, 94, 59);
        case 7:
            return RGB(237, 207, 114);
        case 8:
            return RGB(237, 204, 97);
        case 9:
            return RGB(237, 200, 80);
        case 10:
            return RGB(237, 197, 63);
        case 11:
            return RGB(237, 194, 46);
        case 12:
            return RGB(173, 183, 119);
        case 13:
            return RGB(170, 183, 102);
        case 14:
            return RGB(164, 183, 79);
        case 15:
        default:
            return RGB(161, 183, 63);
    }
}

//等级字体颜色
+ (UIColor *)textColorForLevel:(NSInteger)level
{
    switch (level) {
        case 1:
        case 2:
            return RGB(118, 109, 100);
        default:
            return [UIColor whiteColor];
    }
}

//背景颜色
+ (UIColor *)backgroundColor
{
    return RGB(250, 248, 239);
}

//版的颜色
+ (UIColor *)boardColor
{
    return RGB(204, 192, 179);
}

//分数版的颜色
+ (UIColor *)scoreBoardColor
{
    return RGB(187, 173, 160);
}

//按钮颜色
+ (UIColor *)buttonColor
{
    return RGB(119, 110, 101);
}

//字体
+ (NSString *)boldFontName
{
    return @"AvenirNext-DemiBold";
}


+ (NSString *)regularFontName
{
    return @"AvenirNext-Regular";
}

@end

@interface M2FourTheme : NSObject <M2Theme>
@end

@implementation M2FourTheme

+ (UIImage *)imageForLevel:(NSInteger)level
{
    NSString * imageStr = @"";
    
    switch (level) {
        case 1:
            imageStr = @"d1";
            break;
        case 2:
            imageStr = @"d2";
            break;
        case 3:
            imageStr = @"d3";
            break;
        case 4:
            imageStr = @"d4";
            break;
        case 5:
            imageStr = @"d5";
            break;
        case 6:
            imageStr = @"d6";
            break;
        case 7:
            imageStr = @"d7";
            break;
        case 8:
            imageStr = @"d8";
            break;
        case 9:
            imageStr = @"d9";
            break;
        case 10:
            imageStr = @"d10";
            break;
        case 11:
            imageStr = @"d11";
            break;
        case 12:
            imageStr = @"d12";
            break;
        case 13:
            imageStr = @"d13";
            break;
        case 14:
            imageStr = @"d14";
            break;
        case 15:
        default:
            imageStr = @"d15";
            break;
    }
    
    return [UIImage imageNamed:imageStr];
    
}


//等级颜色
+ (UIColor *)colorForLevel:(NSInteger)level
{
    switch (level) {
        case 1:
            return RGB(238, 228, 218);
        case 2:
            return RGB(237, 224, 200);
        case 3:
            return RGB(242, 177, 121);
        case 4:
            return RGB(245, 149, 99);
        case 5:
            return RGB(246, 124, 95);
        case 6:
            return RGB(246, 94, 59);
        case 7:
            return RGB(237, 207, 114);
        case 8:
            return RGB(237, 204, 97);
        case 9:
            return RGB(237, 200, 80);
        case 10:
            return RGB(237, 197, 63);
        case 11:
            return RGB(237, 194, 46);
        case 12:
            return RGB(173, 183, 119);
        case 13:
            return RGB(170, 183, 102);
        case 14:
            return RGB(164, 183, 79);
        case 15:
        default:
            return RGB(161, 183, 63);
    }
}

//等级字体颜色
+ (UIColor *)textColorForLevel:(NSInteger)level
{
    switch (level) {
        case 1:
        case 2:
            return RGB(118, 109, 100);
        default:
            return [UIColor whiteColor];
    }
}

//背景颜色
+ (UIColor *)backgroundColor
{
    return RGB(250, 248, 239);
}

//版的颜色
+ (UIColor *)boardColor
{
    return RGB(204, 192, 179);
}

//分数版的颜色
+ (UIColor *)scoreBoardColor
{
    return RGB(187, 173, 160);
}

//按钮颜色
+ (UIColor *)buttonColor
{
    return RGB(119, 110, 101);
}

//字体
+ (NSString *)boldFontName
{
    return @"AvenirNext-DemiBold";
}


+ (NSString *)regularFontName
{
    return @"AvenirNext-Regular";
}

@end



@implementation M2Theme

//设置主题
+ (Class)themeClassForType:(NSInteger)type
{
    switch (type) {
        case 1:
            return [M2TwoTheme class];
        case 2:
            return [M2ThereTheme class];
        case 3:
            return [M2FourTheme class];
        default:
            return [M2OneTheme class];
    }
}

@end
