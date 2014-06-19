//
//  ListViewController.h
//  QMPhoto
//
//  Created by QiMengJin on 14-6-15.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface ListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    
    UITableView * listTableView;
    
    
    
    int selectInt;

}

@property (nonatomic, strong) ViewController * delegate;

@end
