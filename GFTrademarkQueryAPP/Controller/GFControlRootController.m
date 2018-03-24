//
//  GFControlRootController.m
//  GFSlide
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "GFControlRootController.h"
#import "UIBarButtonItem+SXCreate.h"
@interface GFControlRootController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation GFControlRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"商标查询";
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage GF_imageWithOriginalName:@"head"] style:UIBarButtonItemStylePlain target:self action:@selector(openDrawer)];
    
    
    /**
     *  广告栏
     */
    _headerView = [[AdvertisingColumn alloc]initWithFrame:CGRectMake(5, 5, Device_Width-10, AD_height)];
    _headerView.backgroundColor = [UIColor blackColor];
    
    
    
   // [self setup];
    
    //[self.view addSubview:self.tableview];
}
-(void)setup{
    
    
#pragma mark -此次加入轮番播放的图片【可实时通过网络更新的图片】
//
//    NSArray *imagesURLStrings = @[
//                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
//
//    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, Device_Width, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
//    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
//    cycleScrollView3.imageURLStringsGroup = imagesURLStrings;
//
//    [self.view addSubview:cycleScrollView3];
//
//载入图片
//    UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 80, 100)];
//
//    [leftIcon setImage:[UIImage imageNamed:@"bg_head"]];
//    [self.view addSubview:leftIcon];
    
    
    
    //[self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftIcon]];
    
    
    /**
     *  广告栏
     */
    _headerView = [[AdvertisingColumn alloc]initWithFrame:CGRectMake(5, 5, Device_Width-10, AD_height)];
    _headerView.backgroundColor = [UIColor blackColor];
    
    
    
    
    
    
    
}
-(void)openDrawer{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.gfSlideVc openDrawer];
}

//设置tableView中的元素个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"测试数据加载。。。";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//在索引路径中取消选定行。
    GFBasicController *vc = [GFBasicController new];
    vc.view.backgroundColor = LXRandomColor;
    vc.title = @"😝😝😋🌶🌶";
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITableView *)tableview{
    
    if (!_tableview) {
        _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVH, Device_Width, Device_Height - NAVH) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.tableFooterView = [UIView new];
        _tableview.rowHeight = 44;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableview;
}


@end
