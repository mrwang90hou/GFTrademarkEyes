//
//  GFControlRootController.m
//  GFSlide
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "GFControlRootController.h"
#import "UIBarButtonItem+SXCreate.h"
#import "CCCycleScrollView.h"
@interface GFControlRootController ()<CCCycleScrollViewClickActionDeleage>//UITableViewDelegate,UITableViewDataSource,
@property (nonatomic, strong)CCCycleScrollView *cyclePlayView;
//@property(nonatomic,strong)UITableView *tableview;
@end

@implementation GFControlRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.navigationItem.title = @"商标查询";
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage GF_imageWithOriginalName:@"head"] style:UIBarButtonItemStylePlain target:self action:@selector(openDrawer)];
    
    [self cycleScrollView];
    
    
    [self setupView];
    
    //[self.view addSubview:self.tableview];
}
-(void)setupView{

//    UIButton *left_btn = [[UIButton alloc]initWithFrame:CGRectMake(-6, 10, 60, 60)];
//    [left_btn setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
//    [left_btn addTarget:self action:@selector(openDrawer) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:left_btn];
    
    
    
    //设计查询操作
    
    
}
-(void)openDrawer{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.gfSlideVc openDrawer];
}
//
////设置tableView中的元素个数
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 5;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if (!cell) {
//        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.text = @"测试数据加载。。。";
//    return cell;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];//在索引路径中取消选定行。
//    GFBasicController *vc = [GFBasicController new];
//    vc.view.backgroundColor = LXRandomColor;
//    vc.title = @"😝😝😋🌶🌶";
//    [self.navigationController pushViewController:vc animated:YES];
//}
//-(UITableView *)tableview{
//    
//    if (!_tableview) {
//        _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, NAVH, Device_Width, Device_Height - NAVH) style:UITableViewStylePlain];
//        _tableview.delegate = self;
//        _tableview.dataSource = self;
//        _tableview.showsVerticalScrollIndicator = NO;
//        _tableview.showsHorizontalScrollIndicator = NO;
//        _tableview.tableFooterView = [UIView new];
//        _tableview.rowHeight = 44;
//        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//        
//    }
//    return _tableview;
//}
//************************************************************************************//

- (void)cycleScrollView
{
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 6; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cycle_image%ld",(long)i]];
        [images addObject:image];
    }
    self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, 0, self.view.frame.size.width, Device_Height/4)];
    self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images];
    self.cyclePlayView.pageDescrips = @[@"大海",@"花",@"长灯",@"阳光下的身影",@"秋树",@"摩天轮"];
    self.cyclePlayView.delegate = self;
    self.cyclePlayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.cyclePlayView];
}

- (void)cyclePageClickAction:(NSInteger)clickIndex
{
    NSLog(@"点击了第%ld个图片:%@",clickIndex,self.cyclePlayView.pageDescrips[clickIndex]);
    //[SVProgressHUD showSuccessWithStatus:@"点击了第个图片:%@",self.cyclePlayView.pageDescrips[clickIndex]];
    [SVProgressHUD showSuccessWithStatus:@"点击了图片"];
    //跳转事件！
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏背景色
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    
//[navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
