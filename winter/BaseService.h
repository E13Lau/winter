//
//  BaseService.h
//  winter
//
//  Created by command.Zi on 15/4/13.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define S_PROPERTY(__TYPE,__NAME) @property (strong, nonatomic) __TYPE *__NAME;

typedef void(^CompletionHandler)(BOOL state,id object,NSError * error);

@interface BaseService : NSObject

S_PROPERTY(AFHTTPRequestOperationManager, client)
@end
