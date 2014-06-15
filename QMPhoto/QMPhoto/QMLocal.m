//
//  QMLocal.m
//  Concise2048
//
//  Created by strongsoft on 14-5-28.
//  Copyright (c) 2014年 QiMeng_LYS. All rights reserved.
//

#import "QMLocal.h"

@implementation QMLocal
#pragma mark - 本地路径
+ (NSString *)pathString {
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@",docsdir);
    return docsdir;
}

#pragma mark - 保存数据到本地
+ (void)saveLocalData:(NSData *)data withName:(NSString *)name {
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",[QMLocal pathString],name];
    [data writeToFile:imagePath atomically:YES];
}
#pragma mark - 获取本地缓存数据
+ (NSData *)getLocalDataName:(NSString *)name {
    NSString *pathStr = [NSString stringWithFormat:@"%@/%@",[QMLocal pathString],name];
    NSData *data = [NSData dataWithContentsOfFile:pathStr];
    return data?data:nil;
}


#pragma mark - 保存照片到本地缓存
+ (void)saveImage:(UIImage *)image withName:(NSString *)name {
    
    NSData *imgData = UIImageJPEGRepresentation(image,0);
    [QMLocal saveLocalData:imgData withName:name];
}




#pragma mark - 获取本地照片
+ (UIImage *)getImageLocalName:(NSString *)name {
    
    UIImage * image = [UIImage imageWithData:[QMLocal getLocalDataName:name]];
    
    return image?image:nil;
}

@end
