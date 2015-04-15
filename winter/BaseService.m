//
//  BaseService.m
//  winter
//
//  Created by command.Zi on 15/4/13.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "BaseService.h"

#define URL_BASE_SERVER @"http://192.168.1.118/"//base server url

@interface BaseService()

@end


@implementation BaseService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.client = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_SERVER]];
        self.client.requestSerializer = [AFJSONRequestSerializer serializer];
        self.client.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

@end
