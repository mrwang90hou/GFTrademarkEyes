//
//  TypePickerView.m
//  YEHBForNursery
//
//  Created by 梁梓龙 on 15/5/7.
//  Copyright (c) 2015年 Loong@krbb. All rights reserved.
//

#import "GFTypePickerView.h"

@implementation GFTypePickerView

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data withKeyForTitle:(NSString *)key
{
    self = [self initWithFrame:frame];
    if (self) {
        //数据存储
        _dataList = data;
        _titleKey = key;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化子视图
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, frame.size.height + 44, frame.size.width, 180)];
        _picker.backgroundColor = [UIColor colorWithRed:0xf7 / 255.0 green:0xf7 / 255.0 blue:0xf7 / 255.0 alpha:1];
        _picker.showsSelectionIndicator = YES;
        _picker.dataSource = self;
        _picker.delegate = self;
        [self addSubview:_picker];
        
        _toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 44)];
        [self loadToolBar];
        [self addSubview:_toolBar];
        
        //___________________标题_____________________________
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:_toolBar.bounds];
        titleLabel.text = @"请选择";
        titleLabel.textColor = [UIColor blackColor];
        [_toolBar addSubview:titleLabel];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        self.hidden = YES;
    }
    return self;
}

- (void)loadToolBar
{
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(hide)];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneSeletingType)];
    
    _toolBar.items = @[cancelItem, flexibleItem, doneItem];
//    _toolBar.barStyle = UIBarStyleDefault;
    _toolBar.barStyle = UIBarStyleBlack;
    _toolBar.translucent = NO;
    
    float systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    if (systemVersion < 7.0) {
//        _toolBar.tintColor = [UIColor colorWithRed:0x8b / 255.0 green:0x24 / 255.2 blue:0xb2 / 255.0 alpha:1];
        
    } else {
        _toolBar.barTintColor = [UIColor colorWithRed:41.0 / 255.0 green:135.0 / 255.2 blue:226.0 / 255.0 alpha:1];
        
        cancelItem.tintColor = [UIColor whiteColor];
        doneItem.tintColor = [UIColor whiteColor];
    }
}

- (void)hide
{
    [UIView animateWithDuration:0.35 animations:^{
        CGRect pickerFrame = _picker.frame;
        pickerFrame.origin.y = self.frame.size.height + 44;
        _picker.frame = pickerFrame;
        
        CGRect toolBarFrame = _toolBar.frame;
        toolBarFrame.origin.y = self.frame.size.height;
        _toolBar.frame = toolBarFrame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
    
    
}

- (void)show
{
    self.hidden = NO;
    
    [UIView animateWithDuration:0.35 animations:^{
        CGRect pickerFrame = _picker.frame;
        pickerFrame.origin.y = self.frame.size.height - 180;
        _picker.frame = pickerFrame;
        
        CGRect toolBarFrame = _toolBar.frame;
        toolBarFrame.origin.y = self.frame.size.height - 180 - 44;
        _toolBar.frame = toolBarFrame;
    }];
}

- (void)doneSeletingType
{
    NSInteger selectedIndex = [_picker selectedRowInComponent:0];
    NSDictionary *selectedDict = _dataList[selectedIndex];
    
    if ([_delegate respondsToSelector:@selector(typePicker:didSeleteTitle:)]) {
        [_delegate typePicker:self didSeleteTitle:selectedDict];
    } else if ([_delegate respondsToSelector:@selector(didSelectTitle:)]) {
        [_delegate didSelectTitle:selectedDict];
    }
    
    [self hide];
}

- (void)setData:(NSArray *)data withKeyForTitle:(NSString *)key
{
    _dataList = data;
    _titleKey = key;
    
    [_picker reloadAllComponents];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataList.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *titleDict = _dataList[row];
    
    return titleDict[_titleKey];
}

#pragma mark - 返回第component列每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

@end
