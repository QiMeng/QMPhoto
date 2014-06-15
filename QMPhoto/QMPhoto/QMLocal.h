//
//  QMLocal.h
//  Concise2048
//
//  Created by strongsoft on 14-5-28.
//  Copyright (c) 2014年 QiMeng_LYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMLocal : NSObject
+ (NSString *)pathString;

/**
 *  保存数据到本地
 *
 *  @param data data description
 *  @param name 文件名称
 */
+ (void)saveLocalData:(NSData *)data withName:(NSString *)name;

//保存照片到本地缓存
+ (void)saveImage:(UIImage *)image withName:(NSString *)name;

//获取本地照片
+ (UIImage *)getImageLocalName:(NSString *)name;

@end
