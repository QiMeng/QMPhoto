//
//  AppDelegate.h
//  QMPhoto
//
//  Created by QiMengJin on 14-6-14.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADInterstitial.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,GADInterstitialDelegate> {
    
    GADInterstitial *splashInterstitial_;
}

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, readonly) NSString *interstitialAdUnitID;

- (GADRequest *)createRequest;

@end
