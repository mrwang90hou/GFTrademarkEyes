
//
//  StyleResultViewController.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/4/26.
//  Copyright © 2016年 gf. All rights reserved.
//
#import "StyleResultViewController.h"
//#import "NSLogVo.h"
#import "StyleResultViewControllerCell.h"
//#import "GFDatePickerView.h"
#import "GFTradeDao.h"
#import "GFTradeVo.h"
#import "GFDeviceVo.h"


@interface StyleResultViewController () <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITextField *input_text;

@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray *mDatas;

@property(nonatomic,strong)UILabel *timeFormLabel;

@property(nonatomic,strong)UILabel *timeToLabel;

//@property (nonatomic, strong) GFDatePickerView *timePickerStart;

//@property (nonatomic, strong) GFDatePickerView *timePickerEnd;

@property (nonatomic, strong) NSString *mStartTime;

@property (nonatomic, strong) NSString *mEndTime;

@property (nonatomic ,strong) NSString *page;

@end

@implementation StyleResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  初始化数据
 */
- (void)setupData {
    _mDatas = [[NSMutableArray alloc] init];
    
    _page = @"1";
    
    //得到往后的时间 --- 对应开始时间
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//公历日历标识符
    NSDateComponents *comps = nil;//日期组件
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    //对应年月日 -号为往后，反之为前
    [adcomps setYear:0];
    [adcomps setMonth:-3];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    //开始时间
    _mStartTime  = beforDate;
    
    //获取当前时间，日期 ---- 对应结束时间
    NSDate *theDate = [NSDate date];
    NSString *theDateString = [dateFormatter stringFromDate:theDate];
    //结束时间
    _mEndTime = theDateString;
    
    //一进界面获取默认 今天往后3个月 数据
    [self requestData];
}

/**
 *  初始化界面
 */
- (void)setupView {
    
    
    // 设置标题背景
    [self setTitle:@"查询结果"];
    //[self setTitle:(@"my_log_title", nil)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    /**************updatedTimeView:输入查询内容*****************/
    
    UIView* updatedTimeView = [UIView new];
    [self.view addSubview:updatedTimeView];
    [updatedTimeView setBackgroundColor:[UIColor colorWithRed:41/255.0 green:134/255.0 blue:227/255.0 alpha:1]];
    [updatedTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(0);
        make.height.mas_equalTo(30);
    }];
    UILabel *updatedTime = [[UILabel alloc]init];
    [updatedTimeView addSubview:updatedTime];
//    [updatedTime setFont:12];
    //[updatedTime setFont:@13];
   // updatedTime.font = 12;
    [updatedTime setFont:[UIFont systemFontOfSize:13]];
    //commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [updatedTime setText:@"网报同步日期:2018年3月19日"];
    [updatedTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(updatedTimeView);
        make.height.mas_equalTo(20);
    }];
    
    
/**************updatedTimeView:输入查询内容*****************/
   
    
/**************btnActionView:重置、提交  按钮操作*****************/
    UIView* btnActionView = [UIView new];
    [self.view addSubview:btnActionView];
    [btnActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(updatedTimeView.mas_bottom).with.offset(0);
        //make.top.equalTo(topView.mas_bottom).with.offset(Device_Height/20);
        make.height.mas_equalTo(75);
    }];
    [self setLayView:btnActionView];
    
    // 列表
    _mTableView = [[UITableView alloc] init];
    [self.view addSubview:_mTableView];
    [_mTableView setDelegate:self];
    [_mTableView setDataSource:self];
    [_mTableView setMj_footer:[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestListFooterRefresh)]];
    [_mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(btnActionView.mas_bottom).with.offset(10);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
    }];
}

#pragma mark - 布局
-(void)setLayView:(UIView*)view {
    
    _input_text = [[UITextField alloc]init];
    //    titleLabel.backgroundColor = [UIColor blackColor];
    [view addSubview:_input_text];
    _input_text.delegate = self;
    //[nameLabel sizeWithfont:14.5 color:[UIColor blackColor] TextAlignment:NSTextAlignmentLeft text:@"my_log_message" mark:1];
    [_input_text setBackgroundColor:[UIColor whiteColor]];
    [_input_text setPlaceholder:@"请输入类似群、商品中/英文"];
    [_input_text setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    // 清除按钮的状态=只有在文本字段中编辑文本时，才会显示覆盖视图。
    _input_text.clearButtonMode = UITextFieldViewModeWhileEditing;
    _input_text.layer.masksToBounds = YES;
    _input_text.layer.cornerRadius = 4;
    _input_text.layer.borderWidth = 1;
    //边界颜色
    _input_text.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    [_input_text mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(view.mas_top).with.offset(5);
        make.left.mas_equalTo(view.mas_left).with.offset(10);
        make.right.mas_equalTo(view.mas_right).with.offset(-10);
        make.height.mas_equalTo(35);
    }];
    
    UIButton *resetBtn = [[UIButton alloc]init];
    [view addSubview:resetBtn];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTintColor:[UIColor redColor]];
    [resetBtn setBackgroundColor:[UIColor greenColor]];
    
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    resetBtn.backgroundColor = [UIColor orangeColor];
    [resetBtn addTarget:self action:@selector(emptyContent) forControlEvents:UIControlEventTouchUpInside];
    //设置边框
    resetBtn.layer.cornerRadius = 4;
    resetBtn.layer.borderWidth = 1;
    resetBtn.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_input_text.mas_bottom).with.offset(5);
        make.left.mas_equalTo(view.mas_left).with.offset(10);
        make.right.mas_equalTo(view.mas_left).with.offset(Device_Width/2+5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(Device_Width/2-15);
    }];
    
    
    UIButton *commitBtn = [[UIButton alloc]init];
    [view addSubview:commitBtn];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTintColor:[UIColor redColor]];
    [commitBtn setBackgroundColor:[UIColor blueColor]];
    
    
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    commitBtn.backgroundColor = [UIColor orangeColor];
    //[commitBtn addTarget:self action:@selector(inquire) forControlEvents:UIControlEventTouchUpInside];
    //设置边框
    commitBtn.layer.cornerRadius = 4;
    commitBtn.layer.borderWidth = 1;
    commitBtn.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_input_text.mas_bottom).with.offset(5);
        make.left.mas_equalTo(resetBtn.mas_right).with.offset(5);
        //make.right.mas_equalTo(view.mas_right).with.offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(Device_Width/2-15);
    }];
    // 分割线
    UIView *line1 = [[UIView alloc] init];
    [view addSubview:line1];
    [line1 setBackgroundColor:[UIColor colorWithWhite:240.0/255 alpha:1]];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(view.mas_left).with.offset(0);
        make.right.mas_equalTo(view.mas_right).with.offset(0);
        make.height.mas_equalTo(1);
    }];
    
}


#pragma mark ===== 列表代理方法 =====

// 返回Cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mDatas.count + 1;
}

// 返回Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40;
    } else {
        return 50;
    }
}

// 返回Cell的样式                                        在索引路径上的行
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CardViewCellId = @"StyleResultViewControllerCellID";
    StyleResultViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:CardViewCellId];
    if (cell == nil)
    {
        cell = [[StyleResultViewControllerCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:CardViewCellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString* cardNumber;
    NSString* cardState;
    NSString* cardStartToStop;
    NSString* cardTime;
    
    if (indexPath.row == 0) {
        cardNumber = @"类似群";
        cardState = @"群组名";
        cardStartToStop = @"商品中文";
        cardTime = @"商品英文";
    } else {

        GFTradeVo *tradeVo = _mDatas[indexPath.row-1];
        cardNumber = [NSString stringWithFormat:@"%ld",indexPath.row];
        cardState = tradeVo.addTime;
        cardStartToStop = tradeVo.equipmentCode;
        cardTime = tradeVo.describe;
    }

    [cell.equipmentNumber sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:cardNumber mark:1];
    cell.equipmentNumber.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipmentNumber.layer.borderWidth = 0.5;
    cell.equipmentNumber.numberOfLines = 0;
//    [cell.equipmentNumber size]
    [cell.equipmentTime sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:cardState mark:1];
    cell.equipmentTime.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipmentTime.layer.borderWidth = 0.5;
    cell.equipmentTime.numberOfLines = 0;
    
    [cell.equipment sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:cardStartToStop mark:1];
    cell.equipment.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipment.layer.borderWidth = 0.5;
    cell.equipment.numberOfLines = 0;
    
    [cell.equipmentDescribe sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:cardTime mark:1];
    cell.equipmentDescribe.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipmentDescribe.layer.borderWidth = 0.5;
    cell.equipmentDescribe.numberOfLines = 0;
    
    return cell;
}
//
//#pragma mark - 选择时间
//-(void)clickChooseTime:(UIButton*)button{
//    
//    if (button.tag == 1000) {
//        
//        if (!_timePickerStart) {
//            _timePickerStart = [[GFDatePickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//            [_timePickerStart setDelegate:self];
//        }
//        [self.view addSubview:_timePickerStart];
//        [_timePickerStart show];
//    } else {
//        
//        if (!_timePickerEnd) {
//            _timePickerEnd = [[GFDatePickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//            [_timePickerEnd setDelegate:self];
//        }
//        [self.view addSubview:_timePickerEnd];
//        [_timePickerEnd show];
//    }
//    
//}

//
//// 选择时间的代理
//- (void)datePicker:(GFDatePickerView *)datePicker didFinishPickingDate:(NSDate *)date {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateString = [dateFormatter stringFromDate:date];
//    if (datePicker == _timePickerStart) {
//        
//        _timeFormLabel.text = dateString;
//        //开始时间
//        _mStartTime = dateString;
//
//    } else {
//        
//        _timeToLabel.text = dateString;
//        //结束时间
//        _mEndTime = dateString;
//    }
//}
//
//#pragma mark - 查询时间
//-(void)clickChooseUnit{
//
//    //时间大小对比
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *dateStart = [dateFormatter dateFromString:_mStartTime];
//    NSDate *dateEnd = [dateFormatter dateFromString:_mEndTime];
//    NSComparisonResult result = [dateStart compare:dateEnd];
//    if (result == NSOrderedDescending) {
//
//        [self showNoticeHudWithTitle:(@"my_log_prompt2", nil) subtitle:(@"my_log_prompt2", nil) onView:self.navigationController.view inDuration:2];
//        return;
//    }
//
//    _page = @"1";
//
//    [self requestData];
//}

#pragma mark - 数据请求
-(void)requestData{
    [GFTradeDao ID:@"12" block:^(NSMutableArray *numberVo, NSError *error) {
        switch (1) {
            case 1:
            {

                if ([_page isEqualToString:@"1"]) {

                    if (numberVo.count == 0) {
                        //没有使用记录
                        //[self showNoticeHudWithTitle:(@"my_log_prompt1", nil) subtitle:(@"my_log_prompt1", nil) onView:self.view inDuration:1.5];

                        [_mTableView.mj_footer endRefreshingWithNoMoreData];
                    } else {

                        [_mTableView.mj_footer endRefreshing];
                    }

                    _mDatas = numberVo;

                } else {

                    if (numberVo.count == 0) {

                        [_mTableView.mj_footer endRefreshingWithNoMoreData];
                    } else {

                        for (GFTradeVo* vo in numberVo) {

                            [_mDatas addObject:vo];
                        }
                        [_mTableView.mj_footer endRefreshing];
                    }

                }

                [_mTableView reloadData];
            }
                break;

        }
 }];

}
//请求列表页脚刷新
-(void)requestListFooterRefresh {
    
    NSInteger num = [_page integerValue];
    num += 1;
    _page = [NSString stringWithFormat:@"%ld",(long)num];
    [self requestData];
}
#pragma mark -按钮操作emptyContent、inquire
-(void)emptyContent{
    [_input_text setText:nil];
}
-(void)inquire{
    [SVProgressHUD showSuccessWithStatus:@"点击提交按钮"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //隐藏背景色
    //[self.navigationController.navigationBar setValue:@100 forKeyPath:@"backgroundView.alpha"];
}
// 输入的回车键键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end
