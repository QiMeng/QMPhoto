//
//  PhotoViewController.m
//  QMPhoto
//
//  Created by strongsoft on 14-6-17.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.

    

    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightItem:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)rightItem:(id)sender {
    
    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
