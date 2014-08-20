//
//  UILabel+Category.m
//  GOODS
//
//  Created by QiMengJin on 14-2-15.
//  Copyright (c) 2014年 QiMengJin. All rights reserved.
//

#import "UILabel+QM_Category.h"


#if ! __has_feature(objc_arc)

#define SAFE_RELEASE(__OBJECT) if((__OBJECT)!= nil) { [(__OBJECT) release]; (__OBJECT) = nil; }
#define QMAutorelease(__v) ([__v autorelease]);
#define QMRelease(__v) ([__v release]);

#else

#define SAFE_RELEASE(__v)
#define QMAutorelease(__v)
#define QMRelease(__v)

#endif

@implementation UILabel (QM_Category)

+ (UILabel *)allocLabelFrame:(CGRect)frame
                    withText:(NSString *)text
               withTextColor:(UIColor *)textColor
                    withFont:(UIFont *)font
          withTextAlignament:(NSTextAlignment)textAlignment
               withBackColor:(UIColor *)backColor
              withAdjustBool:(BOOL)isAdjust{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = backColor?backColor:[UIColor clearColor];
    label.textColor = textColor;
    label.text = text;
    label.font = font;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;
    if (isAdjust) {
        
        [label labelFrameAccording:text andFontSize:label.font.pointSize];
    }
    
    QMAutorelease(label);
    
    return label;
    
}

#pragma mark - 根据标题,字体大小调整UILable的大小
- (UILabel *)labelFrameAccording:(NSString *)text andFontSize:(NSInteger)size  {
    
    
    
    
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:size]];
    
    [self setFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, textSize.width, textSize.height)];

    return self;
}

+ (UILabel *)allocLabelFrame:(CGRect)frame
                    withText:(NSString *)text
               withTextColor:(UIColor *)textColor
                    withFont:(UIFont *)font
          withTextAlignament:(NSTextAlignment)textAlignment
               withBackColor:(UIColor *)backColor{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = backColor?backColor:[UIColor clearColor];
    label.textColor = textColor;
    label.text = text;
    label.font = font;
    label.textAlignment = textAlignment;
    label.numberOfLines = 0;

//        [label labelFrameAccording:text andFontSize:label.font.pointSize];

    [label labelFrameTitle:text font:font size:frame.size];
    
    QMAutorelease(label);
    
    return label;
    
}



- (UILabel *) labelFrameTitle:(NSString *)text font:(UIFont *)font size:(CGSize)size {
    
    CGSize labelsize = [text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    
    [self setFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, labelsize.width, labelsize.height)];
    
    return self;
    
}







@end
