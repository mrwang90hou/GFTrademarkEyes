
//
//  StyleResultViewController.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/4/26.
//  Copyright © 2016年 gf. All rights reserved.
//
#import "StyleResultViewController.h"
//#import "GFLogVo.h"
#import "GFMyLogViewControllerCell.h"
//#import "GFDatePickerView.h"
//#import "GFTradeDao.h"
//#import "GFTradeVo.h"
//#import "GFDeviceVo.h"


@interface StyleResultViewController () <UITableViewDelegate, UITableViewDataSource>

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
    //[self requestData];
}

/**
 *  初始化界面
 */
- (void)setupView {
    
    
    
/**************topView*****************/
    
    UIView* topView = [UIView new];
    [self.view addSubview:topView];
    [topView setBackgroundColor:[UIColor redColor]];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(0);
        make.height.mas_equalTo(Device_Height/12);
    }];
    
/**************topView*****************/
    // 设置标题背景
    [self setTitle:@"查询结果"];
    //[self setTitle:NSNewLocalizedString(@"my_log_title", nil)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIView* view = [UIView new];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        //make.top.mas_equalTo(topView).with.offset(0);
        make.top.equalTo(topView.mas_bottom).with.offset(Device_Height/20);
        make.height.mas_equalTo(75);
    }];
    [self setLayView:view];
    
    // 列表
    _mTableView = [[UITableView alloc] init];
    [self.view addSubview:_mTableView];
    [_mTableView setDelegate:self];
    [_mTableView setDataSource:self];
    //[_mTableView setMj_footer:[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestListFooterRefresh)]];
    [_mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(view.mas_bottom).with.offset(10);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
    }];
}

#pragma mark - 布局
-(void)setLayView:(UIView*)view {
    
    UILabel* nameLabel = [UILabel new];
    //    titleLabel.backgroundColor = [UIColor blackColor];
    [view addSubview:nameLabel];
    //[nameLabel sizeWithfont:14.5 color:[UIColor blackColor] TextAlignment:NSTextAlignmentLeft text:@"my_log_message" mark:1];
    [nameLabel setBackgroundColor:[UIColor greenColor]];
    [nameLabel setText:@"my_log_message"];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(view.mas_top).with.offset(5);
        make.left.mas_equalTo(view.mas_left).with.offset(10);
        make.right.mas_equalTo(view.mas_right).with.offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    
    
    CGFloat widthTime = Device_Width * (68.0 /541);
    CGFloat widthTimeShow = Device_Width * (120.0 /541) + 2.5 ;
    CGFloat widthButton = Device_Width * (50.0 /541) - 2.5 ;
    CGFloat width = Device_Width * (40.0 /541);

    
    UILabel* titleLabel = [UILabel new];
    //    titleLabel.backgroundColor = [UIColor blackColor];
    [view addSubview:titleLabel];
    //[titleLabel sizeWithfont:14.5 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:[NSString stringWithFormat:@"%@:",NSNewLocalizedString(@"my_log_1", nil)] mark:1];
    [titleLabel setText:@"my_log_1"];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(view.mas_left).with.offset(0);
        make.width.mas_equalTo(widthTime);
        make.height.mas_equalTo(30);
    }];
    
    _timeFormLabel = [UILabel new];
    //    _timeFormLabel.backgroundColor = [UIColor redColor];
    [view addSubview:_timeFormLabel];
    //[_timeFormLabel sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:_mStartTime mark:1];
    [_timeFormLabel setBackgroundColor:[UIColor blackColor]];
    _timeFormLabel.layer.borderColor = [UIColor grayColor].CGColor;
    _timeFormLabel.layer.borderWidth = 0.5;
    [_timeFormLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(titleLabel.mas_right).with.offset(0);
        make.width.mas_equalTo(widthTimeShow);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *timeFormButton = [UIButton new];
    //    timeFormButton.backgroundColor = [UIColor greenColor];
    [view addSubview:timeFormButton];
    [timeFormButton setTag:1000];
    //[timeFormButton resizedImageWithOrdinaryName:@"ic_uppressed" HighlightName:@""];
    [timeFormButton addTarget:self action:@selector(clickChooseTime:) forControlEvents:UIControlEventTouchUpInside];
    timeFormButton.layer.borderColor = [UIColor grayColor].CGColor;
    timeFormButton.layer.borderWidth = 0.5;
    [timeFormButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(_timeFormLabel.mas_right).with.offset(0);
        make.width.mas_equalTo(widthButton);
        make.height.mas_equalTo(30);
    }];
    
    UILabel* Label = [UILabel new];
    //    Label.backgroundColor = [UIColor blackColor];
    [view addSubview:Label];
    //[Label sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:NSNewLocalizedString(@"my_orderDetails_to", nil) mark:1];
    [Label setText:@"my_orderDetails_to"];
    [Label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(timeFormButton.mas_right).with.offset(0);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(30);
    }];
    
    _timeToLabel = [UILabel new];
    //    _timeToLabel.backgroundColor = [UIColor redColor];
    [view addSubview:_timeToLabel];
    //[_timeToLabel sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:_mEndTime mark:1];
    _timeToLabel.layer.borderColor = [UIColor grayColor].CGColor;
    _timeToLabel.layer.borderWidth = 0.5;
    [_timeToLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(Label.mas_right).with.offset(0);
        make.width.mas_equalTo(widthTimeShow);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *timeToButton = [UIButton new];
    //    timeToButton.backgroundColor = [UIColor blueColor];
    [view addSubview:timeToButton];
    [timeToButton setTag:1001];
    //[timeToButton resizedImageWithOrdinaryName:@"ic_uppressed" HighlightName:@""];
    [timeToButton addTarget:self action:@selector(clickChooseTime:) forControlEvents:UIControlEventTouchUpInside];
    timeToButton.layer.borderColor = [UIColor grayColor].CGColor;
    timeToButton.layer.borderWidth = 0.5;
    [timeToButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(_timeToLabel.mas_right).with.offset(0);
        make.width.mas_equalTo(widthButton);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *queryButton = [UIButton new];
    //    queryButton.backgroundColor = [UIColor greenColor];
    [view addSubview:queryButton];
    //[queryButton setTitleColor:[UIColor whiteColor] Title:NSNewLocalizedString(@"my_trade_search", nil) font:14.5 backgroundColor:KRGBA(41, 135, 225, 1)];
    //[queryButton addTarget:self action:@selector(clickChooseUnit) forControlEvents:UIControlEventTouchUpInside];
    [queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(timeToButton.mas_right).with.offset(5);
        make.right.mas_equalTo(view.mas_right).with.offset(-5);
        make.height.mas_equalTo(30);
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

// 返回Cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CardViewCellId = @"GFMyLogViewControllerCellID";
    GFMyLogViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:CardViewCellId];
    if (cell == nil)
    {
        cell = [[GFMyLogViewControllerCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:CardViewCellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString* cardNumber;
    NSString* cardState;
    NSString* cardStartToStop;
    NSString* cardTime;
    
    if (indexPath.row == 0) {
        
        cardNumber = NSNewLocalizedString(@"my_log_0", nil);
        cardState = NSNewLocalizedString(@"my_log_1", nil);
        cardStartToStop = NSNewLocalizedString(@"my_log_2", nil);
        cardTime = NSNewLocalizedString(@"my_log_3", nil);
    } else {

//        GFTradeVo *tradeVo = _mDatas[indexPath.row-1];
//        cardNumber = [NSString stringWithFormat:@"%ld",indexPath.row];
//        cardState = tradeVo.addTime;
//        cardStartToStop = tradeVo.equipmentCode;        //<mrwang90hou-2018.01.16PM>
//        //cardStartToStop = tradeVo.equipmentNumber;        //<mrwang90hou-2018.01.16PM>
//
//
//        //cardStartToStop = _equipment;
//
//        cardTime = tradeVo.describe;
    }

    //[cell.equipmentNumber sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:cardNumber mark:1];
    cell.equipmentNumber.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipmentNumber.layer.borderWidth = 0.5;
    cell.equipmentNumber.numberOfLines = 0;
    
    //[cell.equipmentTime sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:cardState mark:1];
    cell.equipmentTime.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipmentTime.layer.borderWidth = 0.5;
    cell.equipmentTime.numberOfLines = 0;
    
    //[cell.equipment sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:cardStartToStop mark:1];
    cell.equipment.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipment.layer.borderWidth = 0.5;
    cell.equipment.numberOfLines = 0;
    
    //[cell.equipmentDescribe sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:cardTime mark:1];
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
//        [self showNoticeHudWithTitle:NSNewLocalizedString(@"my_log_prompt2", nil) subtitle:NSNewLocalizedString(@"my_log_prompt2", nil) onView:self.navigationController.view inDuration:2];
//        return;
//    }
//
//    _page = @"1";
//
//    [self requestData];
//}
//
//#pragma mark - 数据请求
//-(void)requestData{
//
//    GFUserVo *mUserVo = [GFUserDao readUserInfo];
//    //获取使用日志列表
//    [GFTradeDao requestUserLogList:self userID:mUserVo.userID loginID:mUserVo.loginID from:_mStartTime to:_mEndTime pageSize:@"16" page:_page checkCode:mUserVo.checkCode block:^(NSMutableArray *numberVo, NSNumber *errorDescription, NSError *error) {
//
//
//        GFLoginViewController *mLoginVC;
//        switch ([errorDescription intValue]) {
//            case 1:
//            {
//
//                if ([_page isEqualToString:@"1"]) {
//
//                    if (numberVo.count == 0) {
//
//                        [self showNoticeHudWithTitle:NSNewLocalizedString(@"my_log_prompt1", nil) subtitle:NSNewLocalizedString(@"my_log_prompt1", nil) onView:self.view inDuration:1.5];
//
//                        [_mTableView.mj_footer endRefreshingWithNoMoreData];
//                    } else {
//
//                        [_mTableView.mj_footer endRefreshing];
//                    }
//
//                    _mDatas = numberVo;
//
//                } else {
//
//                    if (numberVo.count == 0) {
//
//                        [_mTableView.mj_footer endRefreshingWithNoMoreData];
//                    } else {
//
//                        for (GFTradeVo* vo in numberVo) {
//
//                            [_mDatas addObject:vo];
//                        }
//                        [_mTableView.mj_footer endRefreshing];
//                    }
//
//                }
//
//                [_mTableView reloadData];
//            }
//                break;
//            case -1:
//            case -2:
//            case -3:
//            case -4:
//            case -5:
//            {
//                [self showNoticeHudWithTitle:NSNewLocalizedString(@"all_checkcode_over_date", nil) subtitle:NSNewLocalizedString(@"all_checkcode_over_date", nil) onView:self.navigationController.view inDuration:1.5];
//                mLoginVC = [[GFLoginViewController alloc] init];
//                mLoginVC.isReLogin = YES;
//                [mLoginVC setHidesBottomBarWhenPushed:YES];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.navigationController pushViewController:mLoginVC animated:YES];
//                });
//
//            }
//                break;
//            default:
//                break;
//        }
//
//        /*
//        GFDeviceVo *deviceVo = numberVo[0];
//        //equipment
////        if ([deviceVo.remark isEqualToString:@""]) {
////
////            deviceVo.remark = [NSString stringWithFormat:@"设备-%@",deviceVo.mid];
////        }
//        _equipment = [NSString stringWithFormat:@"设备-%@",deviceVo.mid];
//
//        */
//
//
//    }];
//
//
//}
////请求列表页脚刷新
//-(void)requestListFooterRefresh {
//    
//    NSInteger num = [_page integerValue];
//    num += 1;
//    _page = [NSString stringWithFormat:@"%ld",(long)num];
//    [self requestData];
//}
//
//#pragma mark - 判断卡是否过期
//-(void)cardexpiredMark{
//    
//    GFUserVo *mUserVo = [GFUserDao readUserInfo];
//    [GFUserDao requestUserInfo:self userID:mUserVo.userID loginID:mUserVo.loginID checkCode:mUserVo.checkCode block:^(GFUserVo *mUserVo, NSNumber *errorDescription, NSError *error) {
//        
//        if (error) {
//            return ;
//        }
//        
//        GFLoginViewController *mLoginVC;
//        switch ([errorDescription intValue]) {
//            case 1:
//            {
//                //判断当前激活卡是否已过期
//                if (mUserVo.isguide == YES) {
//                    //过期
//                    [self cardList];
//                    
//                } else {
//                    
//
//                    [self clickChooseUnit];
//                    
//                }
//                
//            }
//                break;
//            case -1:
//            case -2:
//            case -3:
//            case -4:
//            case -5:
//            {
//                [self showNoticeHudWithTitle:NSNewLocalizedString(@"all_checkcode_over_date", nil) subtitle:NSNewLocalizedString(@"all_checkcode_over_date", nil) onView:self.navigationController.view inDuration:1.5];
//                mLoginVC = [[GFLoginViewController alloc] init];
//                mLoginVC.isReLogin = YES;
//                [mLoginVC setHidesBottomBarWhenPushed:YES];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.navigationController pushViewController:mLoginVC animated:YES];
//                });
//                
//            }
//                break;
//            default:
//                break;
//        }
//        
//    }];
//    
//}
//
//#pragma mark - 判断是提示购卡 还是 激活卡
//-(void)cardList{
//    
//    GFUserVo *mUserVo = [GFUserDao readUserInfo];
//    [GFTradeDao requestUserCardList:self userID:mUserVo.userID loginID:mUserVo.loginID activeState:@"2" pageSize:@"-1" page:@"-1"  checkCode:mUserVo.checkCode block:^(NSMutableArray *Vo, NSNumber *errorDescription, NSError *error) {
//        
//        if (error) {
//            return ;
//        }
//        
//        GFLoginViewController *mLoginVC;
//        switch ([errorDescription intValue]) {
//            case 1:
//            {
//                
//                NSString * string;
//                if (Vo.count > 0) {
//                    
//                    //提示去激活卡
//                    string = NSNewLocalizedString(@"cardList_data_prompt1", nil);
//                } else {
//                    
//                    //提示去购卡 或 处理订单
//                    string = NSNewLocalizedString(@"cardList_data_prompt2", nil);
//                }
//                
//                [self showNoticeHudWithTitle:string subtitle:string onView:self.view inDuration:2];
//                
//            }
//                break;
//            case -1:
//            case -2:
//            case -3:
//            case -4:
//            case -5:
//            {
//                [self showNoticeHudWithTitle:NSNewLocalizedString(@"all_checkcode_over_date", nil) subtitle:NSNewLocalizedString(@"all_checkcode_over_date", nil) onView:self.navigationController.view inDuration:1.5];
//                mLoginVC = [[GFLoginViewController alloc] init];
//                mLoginVC.isReLogin = YES;
//                [mLoginVC setHidesBottomBarWhenPushed:YES];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.navigationController pushViewController:mLoginVC animated:YES];
//                });
//                
//            }
//                break;
//            default:
//                break;
//        }
//        
//    }];
//    
//}
//
//-(void)sizeWithfont:(CGFloat)font color:(UIColor *)color TextAlignment:(NSTextAlignment)TextAlignment text:(NSString*)text mark:(NSInteger)mark
//{
//    //1无限缩小，适合段laber，0限制高度
//    if (mark == 1)
//    {
//        [self setAdjustsFontSizeToFitWidth:YES];
//        
//    } else {
//        
//        self.numberOfLines = 0;
//    }
//    self.font = [UIFont systemFontOfSize:font];
//    self.textColor = color;
//    self.textAlignment = TextAlignment;
//    self.text = text;
//    
//}


@end
