
//
//  GFTabbarController.m
//  GFTrademarkQueryAPP
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "GFTabbarController.h"
#import "GFControlRootController.h"
#import "GFTrademarkServiceController.h"
#import "GFRootUseController.h"
#import "GFNavController.h"


@interface GFTabbarController ()

@end

@implementation GFTabbarController

+(void)load
{
    UITabBarItem *titleItem = [UITabBarItem appearance];
    //正常
    //    titleItem.imageInsets = UIEdgeInsetsMake(5.5, 0, -5.5, 0);
    
    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalDict[NSForegroundColorAttributeName] = [UIColor hexStringToColor:@"3c3c3c"];
    [titleItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    //选中
    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
    selectedDict[NSForegroundColorAttributeName] = GFMainColor;
    [titleItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    //    [UITabBar appearance].translucent = NO;  //不能设置为透明
    
    //设置整个项目的item状态
//    //设置item普通状态
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    //    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    //    attrs[NSForegroundColorAttributeName] = [UIColor tabbarNoSelectColor];
//    attrs[NSFontAttributeName] = LXFont(16);
//    attrs[NSForegroundColorAttributeName] = [UIColor hexStringToColor:@"#3c3c3c"];
//    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    //    //设置item不可用状态
    //    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
    //    disabledAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    //    disabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //    [item setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 创建tabbar中间的tabbarItem
    [self setUpMidelTabbarItem];

    [self addAllChildViewControllers];
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, Device_Width, 0.5)];
    view.backgroundColor = [UIColor hexStringToColor:@"#bfbfbf"];
    [self.tabBar addSubview:view];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeLevel" object:nil];
}
#pragma mark -创建tabbar中间的tabbarItem

- (void)setUpMidelTabbarItem {
    
//    LXTabBar *tabBar = [[LXTabBar alloc] init];
//    [self setValue:tabBar forKey:@"tabBar"];
//
//    LXWS(weakSelf);
//    [tabBar setDidClickPublishBtn:^{
//        
//        LXPublishController *hmpositionVC = [[LXPublishController alloc] init];
//        GFNavController *nav = [[GFNavController alloc] initWithRootViewController:hmpositionVC];
//        [weakSelf presentViewController:nav animated:YES completion:nil];
//        
//    }];
    
}

- (void)addAllChildViewControllers {
    
    // 商标查询
    GFControlRootController *assetVc = [[GFControlRootController alloc] init];
    GFNavController *assetRoot =  [self addOneChildViewController:assetVc image:[UIImage GF_imageWithOriginalName:@"ic_search_normal"] selectedImage:[UIImage GF_imageWithOriginalName:@"ic_search_pressed"] title:@"商标查询"];
    
    // 商标服务
    GFTrademarkServiceController *transactionVc = [[GFTrademarkServiceController alloc] init];
    GFNavController *messageRoot =   [self addOneChildViewController:transactionVc image:[UIImage GF_imageWithOriginalName:@"ic_web_services_normal"] selectedImage:[UIImage GF_imageWithOriginalName:@"ic_web_services_pressed"] title:@"商标服务"];
    // 订单
//    GFRootUseController *quotationVc = [[GFRootUseController alloc] init];
//    GFNavController *quotationRoot =   [self addOneChildViewController:quotationVc image:[UIImage imageWithOriginalName:@"use"] selectedImage:[UIImage imageWithOriginalName:@"use1"] title:@"分类"];
//
    // 我的
//    LXPersonController *personVc = [[LXPersonController alloc] init];
//    GFNavController *personRoot =   [self addOneChildViewController:personVc image:[UIImage imageWithOriginalName:@"myPerson"] selectedImage:[UIImage imageWithOriginalName:@"myPerson1"] title:@"我的"];
//
    
    self.viewControllers = @[assetRoot,messageRoot];
}
#pragma mark - 添加一个子控制器
- (GFNavController *)addOneChildViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    GFNavController *navC = [[GFNavController alloc] initWithRootViewController:viewController];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor hexStringToColor:@"#ffffff"];
    
    navC.navigationBar.titleTextAttributes = attributes;
    navC.tabBarItem.title = title;
    navC.tabBarItem.image = image;
    //    navC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    navC.tabBarItem.selectedImage = selectedImage;
    
    return navC;
}
//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    NSInteger index = [self.tabBar.items indexOfObject:item];
//    [self animationWithIndex:index];
//
//    if([item.title isEqualToString:@"我的"])
//    {
//        // 也可以判断标题,然后做自己想做的事<img alt="得意" src="http://static.blog.csdn.net/xheditor/xheditor_emot/default/proud.gif" />
//    }
//}
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    [[tabbarbuttonArray[index] layer]
     addAnimation:animation forKey:nil];
}
-(UINavigationController *)GF_NavController{
    return self.selectedViewController;
}


@end
