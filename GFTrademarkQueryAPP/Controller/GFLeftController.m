
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
@interface GFLeftController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)LeftView *header;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *imageA;
@end

@implementation GFLeftController


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageA.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell =[[ListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.icon.image =[UIImage imageNamed:self.imageA[indexPath.row]];
    cell.typeLabel.text = self.imageA[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.typeClick) {
        self.typeClick(self.imageA[indexPath.row],[GFBasicController class]);
    }
}
-(UITableView *)tableview{
    
    if (!_tableview) {
        _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, self.header.gf_bottom, Device_Width, Device_Height - self.header.gf_bottom) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.tableFooterView = [UIView new];
        _tableview.rowHeight = 50;
//        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableview registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.header];
    
    [self.view addSubview:self.tableview];
}

-(LeftView *)header{
    if (!_header) {
        _header =[LeftView showView];
        _header.frame = CGRectMake(0, 0, Device_Width, 220);
    }
    return _header;
}
-(NSArray *)imageA{
    
    //return @[@"基本信息",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的文件"];
    return @[@"基本信息",@"我的收藏",@"我要分享",@"检测升级",@"设置",@"关于我们"];
}
@end
