//
//  TypePickerView.h
//  YEHBForNursery
//
//  Created by 梁梓龙 on 15/5/7.
//  Copyright (c) 2015年 Loong@krbb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TypePickerViewDelegate;

@interface GFTypePickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *_firstDataList;
    NSArray *_secondDataList;
    
    NSString *_selectedTitle;
    
}

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIToolbar *toolBar;

/** pickerView用到的数据，数组内的元素类型是字典 */
@property (nonatomic, strong) NSArray *dataList;
/** 想要显示的数据所对应的键 */
@property (nonatomic, strong) NSString *titleKey;

@property (nonatomic, assign) id<TypePickerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data withKeyForTitle:(NSString *)key;
- (void)hide;
- (void)show;
- (void)setData:(NSArray *)data withKeyForTitle:(NSString *)key;

@end

@protocol TypePickerViewDelegate <NSObject>

@optional
- (void)didSelectTitle:(NSDictionary *)titleInfo;
- (void)typePicker:(GFTypePickerView *)pickerView didSeleteTitle:(NSDictionary *)titleInfo;

@end
