//
//  BaseAnimation.h
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseAnimation : NSObject
//横向移动
+(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x;
//纵向移动
+(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y;

//缩放
+(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes;
//组合动画
+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes ;


@end
