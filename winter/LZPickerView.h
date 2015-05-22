//
//  LZPickerView.h
//  winter
//
//  Created by command.Zi on 15/5/21.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import <UIKit/UIKit.h>

/**********************************************
 LZPickerView dataType Enum
 **********************************************/
typedef enum{
    LZPicerViewTypePicker,
    LZPicerViewTypeDatePicker
}LZPicerViewType;


@class LZPickerView;

@protocol LZPicderViewDelegate <NSObject>

//代理方法
- (void)lzDatePickerViewValueChanged:(UIDatePicker *)datePickerView value:(NSDate *)date;
- (void)lzPickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@interface LZPickerView : UIControl

//init
- (id)initWithDataType:(LZPicerViewType)dataType;
- (id)initWithDataType:(LZPicerViewType)dataType WithMenuArray:(NSArray *)menuArray;

//delegate
@property (strong, nonatomic) id <LZPicderViewDelegate> delegate;

//显示的string数组
//数组结构可以是@[],@[@[],@[]]
@property (strong, nonatomic) NSArray * menuArray;

//pickerView类型
@property (assign) LZPicerViewType dataType;

//datePicker
@property (strong, nonatomic) UIDatePicker * LZDatePicker;

//Picker
@property (strong, nonatomic) UIPickerView * LZPicker;




@end
