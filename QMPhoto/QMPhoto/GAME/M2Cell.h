//
//  M2Cell.h
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class M2Tile;

@interface M2Cell : NSObject

@property (nonatomic) M2Position position; //网格点

@property (nonatomic, strong) M2Tile *tile; //网格贴图数据

- (instancetype)initWithPosition:(M2Position)position;

@end
