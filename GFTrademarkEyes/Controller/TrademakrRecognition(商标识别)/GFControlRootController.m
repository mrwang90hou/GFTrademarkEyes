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
#import "StyleTableController.h"
#import "StyleResultViewController.h"
#import "ImageCodeResultViewController.h"
#import "GFRangeRootViewController.h"
#import "GFImageCodeViewController.h"
#import "lhScanQCodeViewController.h"
@interface GFControlRootController ()<CCCycleScrollViewClickActionDeleage,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>//UITableViewDelegate,UITableViewDataSource,
@property (nonatomic, strong)CCCycleScrollView *cyclePlayView;
@property (nonatomic, strong) UIButton *inquireButton;
@property (nonatomic,strong)UITextField *text_input;
@property GFBasicController *nextVC;

@property (nonatomic,strong)UIPickerView * pickerView;
@property (nonatomic,strong)UIButton * style_btn;//商品分类表按钮
@property (nonatomic,strong)UIButton * figure_btn;//商标图形要素按钮
@property (nonatomic,strong)UIButton * reject_btn;//商标驳回查询按钮
@property (nonatomic,strong)UIButton * total_btn;

@property (nonatomic,strong)NSArray * selection;//选项
@property (nonatomic,strong)NSArray * number;//保存数字

@end
@implementation GFControlRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商标识别";
    //[self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:left_view_btn]];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage GF_imageWithOriginalName:@"code"] style:UIBarButtonItemStylePlain target:self action:@selector(qrCode2:)];
    [self cycleScrollView];
    //[self setupView];
    [self setupSunbviews];
    /*
    //获取需要展示的数据
    [self loadData];
    // 初始化pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(Device_Width/4, Device_Height/4, self.view.bounds.size.width/2, 80)];
//    [self.pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
//
////        make.top.equalTo(@[[NSNumber numberWithFloat:(Device_Height / 3*1)]]);
////        make.height.equalTo(@200);
//        make.centerX.equalTo(self.view);
//
//    }];
    //    self.pickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_pickerView];
    //指定数据源和委托
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    
    //商品分类表按钮
    _style_btn = [[UIButton alloc]initWithFrame:CGRectMake(Device_Width/4*3+30, Device_Height/4+27, 30 , 30)];
    [_style_btn setImage:[UIImage imageNamed:@"商品分类_bule"] forState:UIControlStateNormal];
    [self.view addSubview:_style_btn];
    [_style_btn addTarget:self action:@selector(clickChooseRange) forControlEvents:UIControlEventTouchUpInside];
    //[_style_btn setHidden:true];
    //商标图形要素按钮figure_btn
    _figure_btn = [[UIButton alloc]initWithFrame:CGRectMake(Device_Width/4*3+30, Device_Height/4+27, 30 , 30)];
    [_figure_btn setImage:[UIImage imageNamed:@"元素_bule"] forState:UIControlStateNormal];
    [self.view addSubview:_figure_btn];
    [_figure_btn addTarget:self action:@selector(clickImageCode) forControlEvents:UIControlEventTouchUpInside];
    [_figure_btn setHidden:true];
    //商标驳回查询按钮reject_btn
    _reject_btn = [[UIButton alloc]initWithFrame:CGRectMake(Device_Width/4*3+30, Device_Height/4+27, 30 , 30)];
    [_reject_btn setImage:[UIImage imageNamed:@"驳回_bule"] forState:UIControlStateNormal];
    [self.view addSubview:_reject_btn];
    [_reject_btn addTarget:self action:@selector(clickImageCode) forControlEvents:UIControlEventTouchUpInside];
    [_reject_btn setHidden:true];
//
    
//    //total_btn
//    _total_btn = [[UIButton alloc]initWithFrame:CGRectMake(Device_Width/4*3+30, Device_Height/4+27, 30 , 30)];
//    [_total_btn setImage:[UIImage imageNamed:@"商品分类表-点击"] forState:UIControlStateNormal];
//    [self.view addSubview:_total_btn];
//    [_total_btn addTarget:self action:@selector(clickImageCode) forControlEvents:UIControlEventTouchUpInside];
//    [_total_btn setHidden:true];
    
    UIButton *left_view_btn = [[UIButton alloc] initWithFrame:CGRectMake(3, 22, 40, 40)];
    [left_view_btn setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    [left_view_btn addTarget:self action:@selector(openDrawer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:left_view_btn];
    */
}

#pragma mark 设置布局
- (void)setupSunbviews {
//    UIButton *qrCodeBtn02=[UIButton buttonWithType:(UIButtonTypeCustom)];
//    //[qrCodeBtn02 setTitle:@"删除" forState:(UIControlStateNormal)];
//    [qrCodeBtn02 setImage:[UIImage imageNamed:@"code2"] forState:UIControlStateNormal];
//    [qrCodeBtn02 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//    qrCodeBtn02.layer.masksToBounds=YES;
//    qrCodeBtn02.layer.cornerRadius=3;
//    qrCodeBtn02.titleLabel.font=[UIFont systemFontOfSize:15];
//    //qrCodeBtn02.backgroundColor=[UIColor greenColor];
//    [qrCodeBtn02 addTarget:self action:@selector(qrCode2:) forControlEvents:UIControlEventTouchUpInside];
//    //qrCodeBtn.frame = CGRectMake(0, 0, 30, 30);
//    qrCodeBtn02.frame=CGRectMake(0, 0, 30, 30);
//    //UIBarButtonItem *pulish = [[UIBarButtonItem alloc] initWithCustomView:qrCodeBtn];
//    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithCustomView:qrCodeBtn02];
//    //[self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: save,pulish,nil]];
//    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: save,nil]];
    //
    //[self setBack_btn:_back_btn];
    //[self.navigationItem setLeftBarButtonItem:_back_btn];
    
    //”商标查询“图片
    UIImageView *adView = [UIImageView new];
    [self.view addSubview:adView];
    [adView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo([NSNumber numberWithFloat:(Device_Width / 16 * 9)]);
    }];
    [adView setHidden:true];
    UIView *titleView = [UIView new];
    [self.view addSubview:titleView];
    [titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(8);
        make.top.equalTo(adView.mas_bottom).with.offset(16);
        make.height.equalTo(@24);
        make.width.equalTo(@4);
    }];
    
    UILabel *titleLabel = [UILabel new];
    [self.view addSubview:titleLabel];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(titleView.mas_trailing).with.offset(8);
        make.centerY.equalTo(titleView);
    }];
    
    UIButton *albumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:albumButton];
    [albumButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(10);
        make.trailing.equalTo(self.view).with.offset(-10);
        make.top.equalTo(adView.mas_bottom).with.offset(70);
        make.height.equalTo(@40);
    }];
    
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:cameraButton];
    [cameraButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(albumButton);
        make.trailing.equalTo(albumButton);
        make.top.equalTo(albumButton.mas_bottom).with.offset(32);
        make.height.equalTo(@40);
    }];
    //[adView assignmentWithImageView:@"GF_Black" model:UIViewContentModeScaleAspectFill];
    titleView.backgroundColor = [UIColor colorWithRed:37/255.0 green:124/255.0 blue:223/255.0 alpha:1];
    titleLabel.text = @"请选择输入识别商标的方式：";
    titleLabel.font = [UIFont systemFontOfSize:15];
    UIImage *normalBackground = [UIImage imageNamed:@"ic_blue bow_normal"];
    normalBackground = [normalBackground resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12) resizingMode:UIImageResizingModeStretch];
    UIImage *pressedBackground = [UIImage imageNamed:@"ic_blue bow_pressed"];
    pressedBackground = [pressedBackground resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12) resizingMode:UIImageResizingModeStretch];
    
    [albumButton setImage:[UIImage imageNamed:@"ic_photo_normal"] forState:UIControlStateNormal];
    [albumButton setTitle:@"相册获取商标" forState:UIControlStateNormal];
    [albumButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [albumButton setBackgroundImage:normalBackground forState:UIControlStateNormal];
    [albumButton setBackgroundImage:pressedBackground forState:UIControlStateHighlighted];
    albumButton.tag = 2200;
    albumButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [albumButton addTarget:self action:@selector(selectImageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cameraButton setImage:[UIImage imageNamed:@"ic_photograph_normal"] forState:UIControlStateNormal];
    [cameraButton setTitle:@"相机获取商标" forState:UIControlStateNormal];
    [cameraButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cameraButton setBackgroundImage:normalBackground forState:UIControlStateNormal];
    [cameraButton setBackgroundImage:pressedBackground forState:UIControlStateHighlighted];
    cameraButton.tag = 2201;
    cameraButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [cameraButton addTarget:self action:@selector(selectImageAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    NSLog(@"Original Image : %@", originalImage);
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil, nil);
    }
    
    
    ////    旧界面
    //    GFPrepareImageViewController *prepareVC = [[GFPrepareImageViewController alloc] init];
    //    prepareVC.originalImage = originalImage;
    //    prepareVC.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:prepareVC animated:YES];
    //
    //    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //新界面
    GFRecognitionHomeImageViewController *prepareVC = [[GFRecognitionHomeImageViewController alloc] init];
    prepareVC.originalImage = originalImage;
    prepareVC.originalToImage = originalImage;
    prepareVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:prepareVC animated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Event Response 事件响应

- (void)selectImageAction:(UIButton *)button {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    
    if (button.tag == 2200) {
        //从相册选择图片
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    } else if (button.tag == 2201) {
        //从相机选择图片
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            [self showAlertViewWithTitle:@"相机不可用！" message:nil cancelButtonTitle:@"确定"];
            return;
        }
    }
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

#pragma mark 加载数据
-(void)loadData {
    //需要展示的数据以数组的形式保存
    self.selection = @[@"商品分类查询",@"商标图形要素"];//@"商标查询",@"商标驳回查询"
    //self.number = @[@"111",@"222",@"333",@"444"];
}

#pragma mark UIPickerView DataSource Method
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.selection.count;
            break;
        case 1:
            result = self.number.count;
            break;
        default:
            break;
    }
    return result;
}
#pragma mark UIPickerView Delegate Method
//指定每行如何展示数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.selection[row];
            break;
        case 1:
            title = self.number[row];
            break;
        default:
            break;
    }
    return title;
}
//选择事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (row) {
//        case 0:
//            _text_input.placeholder = @"请输入您要查询的商标名称或者申请号";
//            _style_btn.hidden = true;
//            _figure_btn.hidden = true;
//            _reject_btn.hidden = true;
//            break;
        case 0:
            _text_input.placeholder  = @"请输入类似群、商品中/英文";
            _style_btn.hidden = false;
            _figure_btn.hidden = true;
            _reject_btn.hidden = true;
            break;
        case 1:
            _text_input.placeholder  = @"请输入图形要素名称/图形要素编码";
            _style_btn.hidden = true;
            _figure_btn.hidden = false;
            _reject_btn.hidden = true;
            break;
        case 2:
            _text_input.placeholder  = @"请输入注册人/国家/城市/代理机构";
            _style_btn.hidden = true;
            _figure_btn.hidden = true;
            _reject_btn.hidden = false;
            break;
        default:
            break;
    }
}

-(void)setupView{
    //设计查询操作
    UIView *adView = [UIView new];
    [self.view addSubview:adView];
    [adView setHidden:true];
    //[adView setBackgroundColor:[UIColor greenColor]];
    [adView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo([NSNumber numberWithFloat:(Device_Height / 3*1)]);
    }];
    UIView *titleView = [UIView new];
    [self.view addSubview:titleView];
    [titleView setHidden:true];
    //[titleView setBackgroundColor:[UIColor blueColor]];
    [titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(8);
        make.top.equalTo(adView.mas_bottom).with.offset(16);
        //make.right.equalTo(self.view).with.offset(4);
        make.leading.equalTo(self.view).with.offset(10);//左侧
        make.trailing.equalTo(self.view).with.offset(-10);//右侧
        
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"商标查询";
    [self.view addSubview:titleLabel];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).with.offset(-20);
        //make.centerY.equalTo(titleView);
        make.centerX.equalTo(titleView);
        
    }];
    titleLabel.hidden = true;
    //************设置选择器*************//
    
    //************设置选择器*************//

    //查询输入框
    _text_input = [[UITextField alloc]init];
    [self.view addSubview:_text_input];
    [_text_input setReturnKeyType:UIReturnKeyGo];
    [_text_input mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(10);//左侧
        make.trailing.equalTo(self.view).with.offset(-10);//右侧   -90
        make.top.equalTo(titleView.mas_bottom).with.offset(10);
        //make.left.equalTo(titleView.mas_bottom).with.offset(20);
        //make.left.equalTo(titleView.mas_bottom).with.offset(20);
        make.height.equalTo(@40);
        //make.leading.equalTo(@200);
    }];
    //搜索🔍logo
    UIImageView *search_btn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_search_normal"]];
    _text_input.clearButtonMode = UITextFieldViewModeWhileEditing;     // 清除按钮的状态=只有在文本字段中编辑文本时，才会显示覆盖视图。
    //_text_input.keyboardType = UIKeyboardTypeASCIICapable;        //限制英文输入
    _text_input.placeholder = @"请输入类似群、商品中/英文";
    //[_text_input setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_text_input setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    _text_input.delegate = self;
    _text_input.backgroundColor = [UIColor whiteColor];
    [_text_input setTextAlignment:NSTextAlignmentCenter];
    _text_input.leftView = search_btn;
    _text_input.leftViewMode = UITextFieldViewModeAlways;
    _text_input.layer.masksToBounds = YES;
    _text_input.layer.cornerRadius = 4;
    _text_input.layer.borderWidth = 1;
    _text_input.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    _inquireButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_inquireButton];
    [_inquireButton mas_updateConstraints:^(MASConstraintMaker *make) {
        //make.leading.equalTo(self.view).with.offset(10);//左侧
        make.trailing.equalTo(self.view).with.offset(-10);//右侧
        make.top.equalTo(titleView.mas_bottom).with.offset(10);//在titleView下面位置：10
        make.leading.equalTo(_text_input.mas_trailing).with.offset(8);//距离左侧的text_input：8位置
        make.height.equalTo(@40);
    }];
    [_text_input setTextColor:[UIColor  blackColor]];
    //[_text_input setClearsOnBeginEditing:true];
    [_inquireButton setTitle:@"查询🕵🏻‍♀️" forState:UIControlStateNormal];
    //[inquireButton setTitle:@"recognition_get_trademark_album"];
    [_inquireButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[inquireButton setBackgroundImage:normalBackground forState:UIControlStateNormal];
    //[inquireButton setBackgroundImage:pressedBackground forState:UIControlStateHighlighted];
    _inquireButton.tag = 2200;
    _inquireButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _inquireButton.backgroundColor = [UIColor orangeColor];
    [_inquireButton addTarget:self action:@selector(inquire) forControlEvents:UIControlEventTouchUpInside];
    //设置边框
    _inquireButton.layer.cornerRadius = 4;
    _inquireButton.layer.borderWidth = 1;
    _inquireButton.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    //***************设置热门搜索词汇*****************//
}
-(void)openDrawer{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.gfSlideVc openDrawer];
}
- (void)cycleScrollView
{
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 7; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"company_image%ld",(long)i]];
        [images addObject:image];
    }
    self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, 0, self.view.frame.size.width, Device_Height/4)];
    self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images];
    //self.cyclePlayView.pageDescrips = @[@"大海",@"花",@"长灯",@"阳光下的身影",@"秋树",@"摩天轮"];
    self.cyclePlayView.delegate = self;
    self.cyclePlayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.cyclePlayView];
}

- (void)cyclePageClickAction:(NSInteger)clickIndex
{
    NSLog(@"点击了第%ld个图片:%@",clickIndex,self.cyclePlayView.pageDescrips[clickIndex]);
    //[SVProgressHUD showSuccessWithStatus:@"点击了第个图片:%@",self.cyclePlayView.pageDescrips[clickIndex]];
    //[SVProgressHUD showSuccessWithStatus:@"点击了图片"];
    //跳转事件！
}
//查询事件
-(void)inquire{
    [SVProgressHUD showSuccessWithStatus:@"点击了查询按钮！"];
    [self hideInput];
    if (_text_input!=nil) {
//        //方式一
//        _nextVC = [[StyleResultViewController alloc]init];
//        UINavigationController *nView = [[UINavigationController alloc]initWithRootViewController:_nextVC];
//        //设置翻转动画
//        _nextVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;       //【水平翻转】
//        //nextVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;        //【闪现】
//        //nextVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;          //【翻页效果】
//        //nextVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;        //【底部推进】
//        [self presentViewController:nView animated:YES completion:nil];
        //方式二
//        StyleResultViewController *advanceSearch = [[StyleResultViewController alloc] init];
//        //当被推时，设置隐藏底部栏。
//        [advanceSearch setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:advanceSearch animated:YES];
        //[self.navigationController.navigationBar setValue:@100 forKeyPath:@"backgroundView.alpha"];
        
        
        
        //NSInteger row=[_pickerViewController.pickerView selectedRowInComponent:0];
        
        NSInteger row = [_pickerView selectedRowInComponent:0];
//        self.sexTF.text = [_sexArr objectAtIndex:row];
//        [self.pickerView removeFromSuperview];
//
//
        
        
        _nextVC = [[GFBasicController alloc]init];
        
        
        switch (row) {
            case 0:
                _nextVC = [[StyleResultViewController alloc] init];
                
                break;
            case 1:
                _nextVC = [[ImageCodeResultViewController alloc] init];
                
                break;
            case 2:
                break;
            default:
                break;
        }
        
        
        //当被推时，设置隐藏底部栏。
        [_nextVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:_nextVC animated:YES];
       
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //隐藏背景色
    //[self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
}
//打开商品分类表事件
-(void)openTable{
    [_style_btn setImage:[UIImage imageNamed:@"商品分类表-点击"] forState:UIControlStateNormal];
    [SVProgressHUD showSuccessWithStatus:@"打开商品分类表！"];
//
//    _nextVC = [[StyleTableController alloc]init];
//
//    UINavigationController *nView = [[UINavigationController alloc]initWithRootViewController:_nextVC];
//    //设置翻转动画
//    _nextVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;       //【水平翻转】
//    //nextVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;        //【闪现】
//    //nextVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;          //【翻页效果】
//    //nextVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;        //【底部推进】
//    [self presentViewController:nView animated:YES completion:nil];
//
  // 跳转方式二
    StyleTableController *advanceSearch = [[StyleTableController alloc] init];
    //当被推时，设置隐藏底部栏。
    [advanceSearch setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:advanceSearch animated:YES];
}
/**
 *  跳转至商品范围选择
 */
- (void)clickChooseRange {
    GFRangeRootViewController *range = [[GFRangeRootViewController alloc] init];
    //range.dataResultDelegate = self;
    [range setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:range animated:YES];
}
/**
 *  点击选择图形要素
 */
- (void)clickImageCode {
    GFImageCodeViewController *imageCode = [[GFImageCodeViewController alloc] init];
    //imageCode.dataResultDelegate = self;
    [imageCode setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:imageCode animated:YES];
}
/* 输入的回车键键
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [self hideInput];
//    if (![_text_input.text isEqualToString:@""]) {
//        [self inquire];
//    }
//    return YES;
//}
*/
// 隐藏键盘
- (void)hideInput {
    [_text_input endEditing:YES];
}
#pragma mark -实现点击文本框跳转的功能
//点击这个方法 就相当于点击了一个按钮，在这里做自己想做的
-(void)textFieldDidBeginEditing:(UITextField*)textField
{
    [textField resignFirstResponder];
    [self w];
    //NSLog(@"string");
    
}
//这个代理方法作用是关闭键盘，按return键返回
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_text_input resignFirstResponder];
    return YES;
    
}
/*单击输入框发生的跳转事件
 */
-(void)w{
    NSInteger row = [_pickerView selectedRowInComponent:0];
    //        self.sexTF.text = [_sexArr objectAtIndex:row];
    //        [self.pickerView removeFromSuperview];
    _nextVC = [[GFBasicController alloc]init];
    switch (row) {
        case 0:
            _nextVC = [[StyleResultViewController alloc] init];
            break;
        case 1:
            _nextVC = [[ImageCodeResultViewController alloc] init];
            break;
        case 2:
            break;
        default:
            break;
    }
    //当被推时，设置隐藏底部栏。
    [_nextVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:_nextVC animated:YES];
    
}
/*#pragma mark -缓存查询数据
////保存和读取历史记录
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    //    NSString * searchHistory = [MyUtil getObjectForKey:@"searchHistory"];
//    //    if (searchHistory) {
//    //        [self.historyArray addObject:searchHistory];
//    //        [self.tableView reloadData];
//    //    }
//    [self readNSUserDefaults];
//}
//
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    DLog(@"开始搜索");
//    self.tableView.hidden = NO;
//}
//
//
//-(IBAction)go:(UITextField *)sender {
//    DLog(@"点击go");
//    if (self.textField.text.length == 0) {
//        [MyUtil showTipText:@"搜索内容不能为空"];
//        return;
//    }
//    //        [MyUtil saveObject:self.textField.text forKey:@"searchHistory"];
//    [self SearchText:self.textField.text];
//
//    GYSearchDetailedViewController * searchDetailed = getViewController(@"searchDetailed", @"FindDoctor");
//    searchDetailed.searchInfo = self.textField.text;
//    [self.navigationController pushViewController:searchDetailed animated:YES];
//
//
//}
//
//-(void)SearchText:(NSString *)seaTxt
//{
//    //    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    //    //读取数组NSArray类型的数据
//    //    self.historyArray = [userDefaultes arrayForKey:@"searchHistory"];
//
//    //    NSMutableArray *searTXT = [self.historyArray mutableCopy];
//    NSMutableArray *searTXT = [[NSMutableArray alloc] init];
//    if (self.historyArray) {
//        searTXT = [self.historyArray mutableCopy];
//    }
//    [searTXT addObject:seaTxt];
//
//    //将上述数据全部存储到NSUserDefaults中
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:searTXT forKey:@"searchHistory"];
//}
//
//-(void)readNSUserDefaults
//{
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    //读取数组NSArray类型的数据
//    //    NSArray *myArray = [userDefaultes arrayForKey:@"searchHistory"];
//    //    NSLog(@"myArray======%@",myArray);
//    self.historyArray = [userDefaultes arrayForKey:@"searchHistory"];
//    [self.tableView reloadData];
//}
//
//
//删除历史记录
////cell允许编辑
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
////删除历史记录
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.historyArray removeObjectAtIndex:indexPath.row - 1];
//
//        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
////修改编辑按钮文字
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
*/

#pragma mark - Event Response 二维码事件响应（第二种）
-(void)qrCode2:(UIButton *)button{
    lhScanQCodeViewController * sqVC = [[lhScanQCodeViewController alloc]init];
    UINavigationController * nVC = [[UINavigationController alloc]initWithRootViewController:sqVC];
    [self presentViewController:nVC animated:YES completion:^{
    }];
}



@end
