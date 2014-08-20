//
//  M2Theme.h
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol M2Theme <NSObject>


+ (UIColor *)boardColor;


+ (UIColor *)backgroundColor;


+ (UIColor *)scoreBoardColor;


+ (UIColor *)buttonColor;


+ (NSString *)boldFontName;


+ (NSString *)regularFontName;


+ (UIColor *)colorForLevel:(NSInteger)level;


+ (UIImage *)imageForLevel:(NSInteger)level;


+ (UIColor *)textColorForLevel:(NSInteger)level;

@end

@interface M2Theme : NSObject

+ (Class)themeClassForType:(NSInteger)type;

@end
