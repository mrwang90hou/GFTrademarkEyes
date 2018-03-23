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
    
    
    [self setup];
    
    [self.view addSubview:self.tableview];
}
-(void)setup{
    
    UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 80, 100)];
    
#pragma mark -此次加入轮番播放的图片【可实时通过网络更新的图片】
    [leftIcon setImage:[UIImage imageNamed:@"bg_head"]];
    [self.view addSubview:leftIcon];
    //[self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:leftIcon]];
    
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
