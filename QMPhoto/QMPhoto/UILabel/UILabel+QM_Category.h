//
//  UILabel+Category.h
//  GOODS
//
//  Created by QiMengJin on 14-2-15.
//  Copyright (c) 2014年 QiMengJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (QM_Category)


/**
 *  创建UILabel ,isAdjust是否根据标题调整大小 : yes 根据标题调整大小, no 默认大小
 *
 *  @param frame          大小
 *  @param text          标题
 *  @param textColor     标题颜色
 *  @param font          字体
 *  @param textAlignment 类型
 *  @param backColor     背景颜色
 *  @param isAdjust      是否根据标题调整大小 : yes 根据标题调整大小, no 默认大小
 *
 *  @return UILabel
 */
+ (UILabel *)allocLabelFrame:(CGRect)frame
                    withText:(NSString *)text
               withTextColor:(UIColor *)textColor
                    withFont:(UIFont *)font
          withTextAlignament:(NSTextAlignment)textAlignment
               withBackColor:(UIColor *)backColor
              withAdjustBool:(BOOL)isAdjust;

/**
 *  根据标题,字体大小调整UILable的大小
 *
 *  @param text 标题
 *  @param size 字体大小
 *
 *  @return UILable
 */
- (UILabel *)labelFrameAccording:(NSString *)text andFontSize:(NSInteger)size ;


+ (UILabel *)allocLabelFrame:(CGRect)frame
                    withText:(NSString *)text
               withTextColor:(UIColor *)textColor
                    withFont:(UIFont *)font
          withTextAlignament:(NSTextAlignment)textAlignment
               withBackColor:(UIColor *)backColor;

@end
