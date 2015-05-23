//
//  LZPickerView.m
//  winter
//
//  Created by command.Zi on 15/5/21.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "LZPickerView.h"
#import <PureLayout.h>


@interface LZPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>{
    //    UIDatePicker * datePickerView;
    //    UIPickerView * dataPickerView;
    NSString * Identifier;
    UIDatePickerMode datePickerMode;
}

@end

@implementation LZPickerView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)initWithDataType:(LZPicerViewType)dataType {
    self = [super init];
    if (self) {
        _dataType = dataType;
    }
    return self;
}

- (id)initWithDatePickerMode:(UIDatePickerMode)mode {
    self = [super init];
    if (self) {
        datePickerMode = mode;
        _dataType = LZPicerViewTypeDatePicker;
    }
    return self;
}


- (id)initWithMenuArray:(NSArray *)menuArray {
    self = [super init];
    if (self) {
        _menuArray = menuArray;
        _dataType = LZPicerViewTypePicker;
    }
    return self;
}

-(void)setMenuArray:(NSArray *)menuArray {
    if (!_menuArray) {
        _menuArray = [NSArray new];
    }
}

- (void)setRestorationIdentifier:(NSString *)restorationIdentifier {
    Identifier = restorationIdentifier;
}

- (void)show {
    [self setup];
}

- (void)setup {
    //intiView
    //使用    self.alpha = 0.5f;
    //影响到子View的透明度
    self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0f];
    self.frame = [[UIScreen mainScreen]bounds];
    [self addTarget:self action:@selector(tagOne) forControlEvents:UIControlEventTouchDown];
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            [window addSubview:self];
            break;
        }
    }
    [UIView animateWithDuration:0.2f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5f];
    }];
    /***LZPicerViewTypeDatePicker Logic***/
    if (_dataType == LZPicerViewTypeDatePicker) {
        self.LZDatePicker = [[UIDatePicker alloc]init];
        self.LZDatePicker.datePickerMode = datePickerMode;
        [self.LZDatePicker addTarget:self action:@selector(datePickerViewValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.LZDatePicker setAlpha:1.0f];
        [self.LZDatePicker setBackgroundColor:[UIColor whiteColor]];
        [self.LZDatePicker setFrame:CGRectMake(0, self.frame.size.height, self.LZDatePicker.frame.size.width, self.LZDatePicker.frame.size.height)];
        [UIView animateWithDuration:0.2f animations:^{
            self.LZDatePicker.frame = CGRectMake(0, self.frame.size.height-self.LZDatePicker.frame.size.height, self.LZDatePicker.frame.size.width, self.LZDatePicker.frame.size.height);
        }];
        if (Identifier) {
            self.LZDatePicker.restorationIdentifier = Identifier;
        }
        //        [self.LZDatePicker autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        //        [self.LZDatePicker autoPinEdgeToSuperviewEdge:ALEdgeRight];
        //        [self.LZDatePicker autoPinEdgeToSuperviewEdge:ALEdgeTop];
        //        [self.LZDatePicker autoSetDimensionsToSize:[self.LZDatePicker intrinsicContentSize]];
        [self addSubview:self.LZDatePicker];
    }
    /***LZPicerViewTypePicker Logic***/
    else if (_dataType == LZPicerViewTypePicker) {
        self.LZPicker = [[UIPickerView alloc]init];
        self.LZPicker.delegate = self;
        self.LZPicker.backgroundColor = [UIColor whiteColor];
        [self.LZPicker setFrame:CGRectMake(0, self.frame.size.height, self.LZPicker.frame.size.width, self.LZPicker.frame.size.height)];
        [UIView animateWithDuration:0.2f animations:^{
            self.LZPicker.frame = CGRectMake(0, self.frame.size.height-self.LZPicker.frame.size.height, self.LZPicker.frame.size.width, self.LZPicker.frame.size.height);
        }];
        if (Identifier.length) {
            self.LZPicker.restorationIdentifier = Identifier;
        }
        [self addSubview:self.LZPicker];
    }
}

- (void)tagOne {
    if (_dataType == LZPicerViewTypeDatePicker) {
        [UIView animateWithDuration:0.2f animations:^{
            self.LZDatePicker.frame = CGRectMake(0, self.frame.size.height, self.LZDatePicker.frame.size.width, self.LZDatePicker.frame.size.height);
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.LZDatePicker removeFromSuperview];
            self.LZDatePicker = nil;
            [self removeFromSuperview];
        }];
    }else if (_dataType == LZPicerViewTypePicker) {
        [UIView animateWithDuration:0.2f animations:^{
            self.LZPicker.frame = CGRectMake(0, self.frame.size.height, self.LZPicker.frame.size.width, self.LZPicker.frame.size.height);
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.LZPicker removeFromSuperview];
            self.LZPicker = nil;
            self.menuArray = nil;
            [self removeFromSuperview];
        }];
    }
    
}

- (void)datePickerViewValueChanged:(UIDatePicker *)datePickerView {
    [self.delegate lzDatePickerViewValueChanged:datePickerView value:self.LZDatePicker.date];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _menuArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _menuArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.delegate lzPickerView:pickerView didSelectRow:row inComponent:component];
}


@end
