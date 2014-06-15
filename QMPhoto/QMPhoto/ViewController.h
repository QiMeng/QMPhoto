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
@interface ViewController : UIViewController <iCarouselDataSource, iCarouselDelegate,GADInterstitialDelegate>{
    
    __weak IBOutlet UIView *preView;
    iCarousel *myCarousel;
    
    
    __weak IBOutlet UIView *toolView;
    __weak IBOutlet UILabel *currentLabel;
    
    __weak IBOutlet UILabel *highestLabel;
    
    

    
    
    __weak IBOutlet UIView *gameView;
    
    
    GADInterstitial *interstitial_;
}


@property(nonatomic, retain) GADInterstitial *interstitial;
@end
