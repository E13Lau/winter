//
//  BaseModel.m
//  winter
//
//  Created by command.Zi on 15/4/13.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "BaseModel.h"

#define CACHE_TIME 36*36*24*2  //s*m*h*d

#define S_PROPERTY(__TYPE,__NAME) @property (strong, nonatomic) __TYPE *__NAME;
#define W_PROPERTY(__TYPE,__NAME) @property (weak, nonatomic) __TYPE *__NAME;

@implementation BaseModel
-(id)init
{
    self = [super init];
    return self;
}
//DEF_SINGLETON

@end
