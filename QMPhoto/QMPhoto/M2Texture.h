//
//  M2Texture.h
//  Concise2048
//
//  Created by strongsoft on 14-5-21.
//  Copyright (c) 2014年 QiMeng_LYS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QMLocal.h"
#define TextureState [M2Texture state]

@interface M2Texture : NSObject {
    
    
    
}

+ (M2Texture *)state;   //单例

@property (nonatomic, strong) NSMutableArray * imageArray;

- (void)initImageDicFromArray:(NSArray*)array;

- (UIImage *)imageForLevel:(NSInteger)level;

@end
