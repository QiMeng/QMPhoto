//
//  ViewController.h
//  QMPhoto
//
//  Created by QiMengJin on 14-6-14.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <iCarousel.h>
#import <MZFormSheetController.h>

#import "GADInterstitial.h"
#import "GADInterstitialDelegate.h"

#import "GADBannerView.h"

#import "M2Scene.h"

@interface ViewController : UIViewController <iCarouselDataSource, iCarouselDelegate,GADInterstitialDelegate,GADBannerViewDelegate>{
    
    __weak IBOutlet UIView *preView;
    iCarousel *myCarousel;
    
    
    __weak IBOutlet UIView *toolView;
    __weak IBOutlet UILabel *currentLabel;
    
    __weak IBOutlet UILabel *highestLabel;

    
    M2Scene *gameView;
    
    
    GADInterstitial *interstitial_;
    
    // 广告条
    GADBannerView *bannerView_;
}


@property(nonatomic, retain) GADInterstitial *interstitial;


/**
 *  重新开始
 */
- (void)agreeGame;

- (void)endGame:(BOOL)isWin ;

- (void)updateScore:(int)score;

- (void)currentBaseLevel:(int)level;


@end
