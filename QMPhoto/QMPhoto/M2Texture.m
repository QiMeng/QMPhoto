//
//  M2Texture.m
//  Concise2048
//
//  Created by strongsoft on 14-5-21.
//  Copyright (c) 2014年 QiMeng_LYS. All rights reserved.
//

#import "M2Texture.h"

@implementation M2Texture


+ (M2Texture *)state
{
    static M2Texture *state = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        state = [[M2Texture alloc] init];
        
        
    });
    
    return state;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        
        _imageArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)initImageDicFromArray:(NSArray*)array {
    
    [_imageArray removeAllObjects];

    
    for (NSString * str in array) {
        
        if ([str isKindOfClass:[NSString class]]) {

            UIImage * image = [QMLocal getImageLocalName:str];
            
            if (!image) {
                image = [UIImage imageNamed:str];
            }
 
            [_imageArray addObject:image];
        }
    }
    
}

- (UIImage *)imageForLevel:(NSInteger)level {

    if (level<0 || level>_imageArray.count) {
        return nil;
    }
    
    return [_imageArray objectAtIndex:level];
}




@end
