//
//  SaKUIScrollView.h
//  winter
//
//  Created by command.Zi on 15/1/26.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SaKuraScrollView;

@protocol SaKuraScrollViewDelegate <NSObject>

//点击事件代理方法
-(void)selectPageAtScrollView:(SaKuraScrollView *)SaKuraScrollView selectPage:(NSInteger )selectPage;

@end

@interface SaKuraScrollView : UIView


@property (nonatomic,strong) NSMutableArray *imagesMutableArray;
@property (nonatomic, weak) id <SaKuraScrollViewDelegate> sakuraDelegate;

@end
