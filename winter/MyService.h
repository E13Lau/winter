//
//  MyService.h
//  winter
//
//  Created by command.Zi on 15/4/13.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyModal.h"
#import "BaseService.h"

@interface MyService : BaseService

#pragma -mark get guide category
- (void)getGuidesCategoryListWithHandler:(CompletionHandler)handler;

#pragma -mark get guide list
- (void)getGuidesListWithCategoryId:(int)categoryId limit:(int)limit offset:(int)offset handler:(CompletionHandler)handler;

@end
