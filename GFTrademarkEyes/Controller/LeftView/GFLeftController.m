
//
//  GFLeftController.m
//  GFSlide
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "GFLeftController.h"
#import "LeftView.h"
#import "ListCell.h"
#import "GFNavController.h"

#import "MyInformationController.h"
#import "MyFavoriteController.h"
#import "ShareController.h"
#import "AdviceController.h"
#import "UpdateController.h"
#import "SetUpController.h"
#import "AboutUsController.h"
#import "ConnectToUsController.h"
#import "VersionInformationController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>


@interface GFLeftController ()<UITableViewDelegate, UITableViewDataSource ,UIAlertViewDelegate>
@property(nonatomic,strong)LeftView *header;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *imageA;
@property(nonatomic,strong)UINavigationController *recognitionNavigation;
@end

@implementation GFLeftController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //[self launchAnimation];
    //UINavigationController *w = [[UINavigationController alloc]initWithRootViewController:self];
//    self.viewControllers(_recognitionNavigation);
    //self.viewControllers = [NSArray arrayWithObjects:w, nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //UINavigationController *recognitionNavigation = [[UINavigationController alloc]initWithRootViewController:self.view];
    //self.viewControllers = @[ recognitionNavigation];
    //self.viewControllers = @[_recognitionNavigation];
    //self.view = _recognitionNavigation;
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.header];         //加载广告轮翻图
    [self.view addSubview:self.tableview];      //加载左视图的菜单列表
    [_tableview setBackgroundColor:[UIColor blackColor]];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.size.equalTo(self.view);
        //make.top.equalTo(self.view).offset(0);
    }];
    //1、在viewDidLoad中添加观察者
    [_tableview addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
    
//    // 登录按钮
//    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 200, 80)];
//    [loginButton setTitle:@"跳转至扫码登录☞" forState:UIControlStateNormal];
//    [loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    //[loginButton setBackgroundImage:[UIImage imageNamed:@"bg_btn_login_normal"] forState:UIControlStateNormal];
//    //[loginButton setBackgroundImage:[UIImage imageNamed:@"bg_btn_login_pressed"] forState:UIControlStateHighlighted];
//    [loginButton addTarget:self action:@selector(w) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginButton];
}
//-(void)w{
//
//    AboutUsController *nextVC = [[AboutUsController alloc]init];
//    //[self.navigationController pushViewController:nextVC animated:YES];
//    [self presentViewController:_recognitionNavigation animated:YES completion:nil];
//    //[myViewController presentModalViewController: navigationController];
//}
//2、重写observeValueForKeyPath方法，一旦UITableView的contentSize发生改变，就会调用这个方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    CGRect frame = _tableview.frame;
    frame.size = _tableview.contentSize;
    _tableview.frame = frame;
}



#pragma mark -显示账户图片展示LeftView.xib
-(LeftView *)header{
    if (!_header) {
        //_header =[LeftView showView];
        _header.frame = CGRectMake(0, 0, Device_Width, Device_Height/3);
    }
    return _header;
}
#pragma mark -布局tableView
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, self.header.gf_bottom, Device_Width, Device_Height - self.header.gf_bottom) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;       //显示垂直滚动指标：NO
        _tableview.showsHorizontalScrollIndicator = NO;     //显示水平滚动指标：NO
        _tableview.tableFooterView = [UIView new];          //表页脚视图
        
#pragma mark -tableView每个元素的高度改为：屏幕按比例分配
        _tableview.rowHeight = 50;                          //行高：50
//        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableview registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tableview;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //使用标识符分隔可重用单元格。
    ListCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell =[[ListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.icon.image =[UIImage imageNamed:self.imageA[indexPath.row]];
    cell.typeLabel.text = self.imageA[indexPath.row];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    //在索引路径中取消选定行。
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    if (self.typeClick) {                   //判断是否被点击
//        self.typeClick(self.imageA[indexPath.row],[GFBasicController class]);
//    }
//}

//设置tableView内的图片与名称
-(NSArray *)imageA{
    //return @[@"基本信息",@"我的收藏",@"我要分享",@"意见反馈",@"给个好评",@"检测升级",@"设置",@"关于我们"];
    //return @[@"我的收藏",@"我要分享",@"意见反馈",@"给个好评",@"检测升级",@"版本信息",@"联系我们",@"关于我们"];
    return @[@"我要分享",@"意见反馈",@"给个好评",@"检测升级",@"版本信息",@"联系我们",@"关于我们"];
}
//tableView元素个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageA.count;
}

// 列表点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //在索引路径中取消选定行。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GFLeftBasicController *nextVC;
    switch (indexPath.row+1) {
        case 1:
            //nextVC = [[GFMyReplaceEquipmentViewController alloc] init];
//            nextVC = [[ShareController alloc]init];
//            [SVProgressHUD showSuccessWithStatus:@"我要分享"];
            //return;
            [self shareAction];
            break;
        case 2:
            //nextVC = [[GFMyPasswordViewController alloc] init];
            //nextVC = [[AdviceController alloc]init];
            //[SVProgressHUD showSuccessWithStatus:@"意见反馈"];
            //[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto:mrwang90hou@126.com"]];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto:mrwang90hou@126.com"] options:@{} completionHandler:^(BOOL success) {
                NSLog(@"意见反馈");
            }];
            
            break;
        case 3:
            //nextVC = [[GFMyCardViewController alloc] init];
            //GFBasicController *nextVC = [[GFBasicController alloc]init];
            //[SVProgressHUD showSuccessWithStatus:@"给个好评"];
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=529826126"]];
            //修改完成ID信息
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1372621662"] options:@{} completionHandler:^(BOOL success) {
                NSLog(@"给个好评");
            }];
            
            break;
        case 4:
            //nextVC = [[GFMyRechargeViewController alloc] init];
            nextVC = [[UpdateController alloc]init];
            [SVProgressHUD showSuccessWithStatus:@"已经是最新版本！"];
            break;
        
        case 5:
            nextVC = [[VersionInformationController alloc] init];
            //弹出框
            //[SVProgressHUD showSuccessWithStatus:@"版本信息"];
            break;
        case 6:
            //nextVC = [[GFMyOrderDetailsViewController alloc] init];
            
            // 跳转回登录界面
            //UIStoryboard *storyBoard = [UIStoryboard storyboardWith]
            //            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ConnectToUsController" bundle:nil];
            //
            //            nextVC = [storyBoard instantiateInitialViewController];
            
            nextVC = [[ConnectToUsController alloc]init];
            //[SVProgressHUD showSuccessWithStatus:@"联系我们"];
            break;
        case 7:
            //nextVC = [[GFMyLogViewController alloc] init];
            nextVC = [[AboutUsController alloc]init];
            //[SVProgressHUD showSuccessWithStatus:@"关于我们"];
            break;
        default:
            break;
    }
    
//    NSInteger row = indexPath.row+1;
//    if (self.typeClick && row != 1 && row != 2 && row != 3 && row != 4) {
//        self.typeClick(self.imageA[indexPath.row],[nextVC class]);
//    }
//
    
    
    
    //[self.navigationController pushViewController:nextVC animated:YES];
    //判断是否被点击
    NSInteger row = indexPath.row+1;
    if (row != 1 && row != 2 && row != 3 && row != 4) {
        GFNavController *nView = [[GFNavController alloc]initWithRootViewController:nextVC];
        //_recognitionNavigation = [[UINavigationController alloc]initWithRootViewController:self];
        //设置翻转动画
        nextVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;       //【水平翻转】
        //nextVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;        //【闪现】
        //nextVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;          //【翻页效果】
        //nextVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;        //【底部推进】
        //[nextVC setHidesBottomBarWhenPushed:YES];
        [self presentViewController:nView animated:YES completion:nil];
//        AboutUsController *nv = [[AboutUsController alloc]init];
        //[_recognitionNavigation pushViewController:nextVC animated:YES];
         //[self.navigationController pushViewController:nv animated:YES];
    }
//
//    if (indexPath.row != 8) {
//        //[nextVC setHidesBottomBarWhenPushed:YES];
//        //[self.navigationController pushViewController:nextVC animated:YES];
//        [self presentViewController:nextVC animated:YES completion:nil];
//    }
}
-(void)shareAction{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"bg_head"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[self launchAnimation];
}


//方案不可行，每次加载Tabbar的时候都会重新加载一遍这个LaunchScreenView
#pragma mark - Private Methods
- (void)launchAnimation {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    //设置要进入的页面
    UIViewController *viewController = [storyBoard instantiateInitialViewController];
    
    //UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    UIView *launchView = viewController.view;
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
}
@end
