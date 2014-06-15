//
//  ListViewController.m
//  QMPhoto
//
//  Created by QiMengJin on 14-6-15.
//  Copyright (c) 2014年 QiMengJin_LYS. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@property (nonatomic, strong) NSArray * listArray;


@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    
    self.title = @"设置";
    
    _listArray = @[@[@"继续",@"重新开始"],
  @[@"音效",@"音乐"],
                   @[@"排行榜"],
                   
  @[@"2",@"4",@"8",@"16",@"32",@"64",@"128",@"256",@"512",@"1024",@"2048"]];
    
    
    
    listTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    
    
    
    
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return _listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSArray * array = [_listArray objectAtIndex:section];
    return array.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];

    }
    
    NSArray * array = [_listArray objectAtIndex:indexPath.section];
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        //继续
        if (indexPath.row == 0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        if (indexPath.row == 1) {
#warning 重新开始
            
            
            
        }
        
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
#warning 音效
        }
        if (indexPath.row == 1) {
#warning 音乐
        }
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
#warning 排行榜
    }
    
    if (indexPath.section == 3) {
#warning 图片
    }
    


    
    
    
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
