//
//  M2Scene.h
//  m2048
//
//  Created by QiMengJin on 14-5-3.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@interface M2Scene : UIView

@property (nonatomic, weak) ViewController *delegate;


- (void)startNewGame;
- (void)updateTheme ;

@end
