//
//  GFRangeRootViewController.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/17.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFRangeRootViewController.h"
#import "DLTabedSlideView.h"
#import "GFRangeFirstViewController.h"
#import "GFRangeSecondViewController.h"
#import "GFRangeSearchViewController.h"

#import "UIBarButtonItem+GFNavigation.h"

@interface GFRangeRootViewController () <DLTabedSlideViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) DLTabedSlideView *rootView;
@property (nonatomic, strong) GFRangeFirstViewController *firstVC;
@property (nonatomic, strong) GFRangeSecondViewController *secondVC;
@property (nonatomic, strong) GFRangeSearchViewController *searchVC;

@end

@implementation GFRangeRootViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];//不隐藏导航栏
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    self.title = @"商品范围分类表";

    //继续
    [self initView:0];      //右侧barbutton:全类选择器
    [self initPageView];    //初始化标签内容页
    //弹出框
    //[self initAlertView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 弹出框
-(void)initAlertView {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSNewLocalizedString(@"Warm_prompt", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        //添加Button
        [alertController addAction: [UIAlertAction actionWithTitle: NSNewLocalizedString(@"NO", nil) style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //取消
            [self.navigationController popViewControllerAnimated:YES];
            return ;
            
        }]];
        [alertController addAction: [UIAlertAction actionWithTitle: NSNewLocalizedString(@"YES", nil) style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //继续
            _rootView.hidden = NO;
            return ;
            
        }]];
        [self presentViewController: alertController animated: YES completion: nil];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSNewLocalizedString(@"Warm_prompt", nil) delegate:self cancelButtonTitle:NSNewLocalizedString(@"NO", nil) otherButtonTitles:NSNewLocalizedString(@"YES", nil),nil];
        [alertView show];
        
    }
    
}
//                                          点击按钮指数
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex)
    {
        //取消
        [self.navigationController popViewControllerAnimated:YES];
        return ;
    }
    
    if (1 == buttonIndex)
    {
        //继续
        _rootView.hidden = NO;
        return ;
    }
    
}

/**
 *  导航栏
 */
- (void)initView:(NSInteger)number {
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem new] setButton:@"全类" controller:self response:@selector(determine)];
}

/**
 *   导航栏 rightBarbutton确定响应
 */
-(void)determine {
    
        if (_firstVC.dataResultDelegate) {
            [_dataResultDelegate chooseRangeAllData];
        }
        [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  初始化标签内容页
 */
- (void)initPageView {
    _firstVC = [[GFRangeFirstViewController alloc] init];
    _firstVC.dataResultDelegate = self.dataResultDelegate;
    _secondVC = [[GFRangeSecondViewController alloc] init];
    _secondVC.dataResultDelegate = self.dataResultDelegate;
    _searchVC = [[GFRangeSearchViewController alloc] init];
    _searchVC.dataResultDelegate = self.dataResultDelegate;
    _rootView = [[DLTabedSlideView alloc] init];
    [self.view addSubview:_rootView];
    [_rootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    _rootView.baseViewController = self;
    _rootView.tabItemNormalColor = [UIColor blackColor];
    _rootView.tabItemSelectedColor = [UIColor blackColor];
    _rootView.tabbarTrackColor = [UIColor colorWithRed:41.0/255 green:134.0/255 blue:227.0/255 alpha:1];
    _rootView.tabbarHeight = 44;
    _rootView.tabbarBackgroundImage = [UIImage imageNamed:@"bg_white"];
    _rootView.tabbarBottomSpacing = 5;
    //DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"类别" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"类似群" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"商品查询" image:nil selectedImage:nil];
    _rootView.tabbarItems = @[item2, item3];//item1,
    _rootView.delegate = self;
    _rootView.DLdelegate = self;
    _rootView.boolMark = 2;
    [_rootView buildTabbar];
    _rootView.selectedIndex = 0;
    _rootView.hidden = NO;
}

// 标签控件代理方法，返回标签的数量
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 2;//3
}

// 标签控件代理方法，返回对应标签的内容
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index {
    switch (index) {
//        case 0:{
//            return _firstVC;
//            break;
//        }
        case 0:{
            return _secondVC;
            break;
        }
        case 1:{
            return _searchVC;
            break;
        }
        default:
            return nil;
    }
}

/**
 *  切换视图的代理响应
 *
 *  @param index 0~2 
 */
- (void )chooseTabed:(NSInteger)index{
    [self initView:index];
}

/**
 *  返回上一个页面
 */
- (void)popView {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
