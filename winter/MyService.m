//
//  MyService.m
//  winter
//
//  Created by command.Zi on 15/4/13.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "MyService.h"

//获取分类
#define URL_GUIDES_CATEGORY @"isports/index.php/guides_categories"
//获取某一分类下的攻略列表 post发布攻略
#define URL_GUIDES_LIST @"isports/index.php/guides"

#define IFMAINID(ID,URL)     if (categoryId) {\
url = [NSString stringWithFormat:@"%@/%d",URL,ID];\
} else {\
    url = URL_GUIDES_LIST;\
}
#define IFNUMBER(int)
#define IFSTRING(string)

@implementation MyService

#pragma -mark get guide category
- (void)getGuidesCategoryListWithHandler:(CompletionHandler)handler
{
    [self.client GET:URL_GUIDES_CATEGORY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array  = (NSArray *)responseObject;
        if (array) {
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for (NSDictionary *object in array) {
                
                [result addObject:[self createGuideCategoryModel:object]];
            }
            handler(YES,result,nil);
        } else {
            handler(YES,nil,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(NO, nil, error);
    }];
}

#pragma -mark get guide list
- (void)getGuidesListWithCategoryId:(int)categoryId limit:(int)limit offset:(int)offset handler:(CompletionHandler)handler
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *url = nil;
    if (categoryId) {
        url = [NSString stringWithFormat:@"%@/%d",URL_GUIDES_LIST,categoryId];
    } else {
        url = URL_GUIDES_LIST;
    }
    if (limit) {
        [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    } else {
        [params setObject:[NSNumber numberWithInt:15] forKey:@"limit"];
    }
    if (offset) {
        [params setObject:[NSNumber numberWithInt:offset] forKey:@"offset"];
    } else {
        [params setObject:[NSNumber numberWithInt:0] forKey:@"offset"];
    }
    [self.client GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array  = (NSArray *)responseObject;
        if (array) {
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for (NSDictionary *object in array) {
                
                [result addObject:[self createGuideModel:object]];
            }
            handler(YES,result,nil);
        } else {
            handler(YES,nil,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(NO, nil ,error);
    }];
}

#pragma mark -
- (GuideModel *)createGuideModel:(NSDictionary *)object
{
    if (!object) {
        return  nil;
    }
    GuideModel *guide = [[GuideModel alloc] init];
    guide.guideId = [object objectForKey:@"id"];
    guide.guideTitle = [object objectForKey:@"title"];
    guide.guideTime = [object objectForKey:@"time"];
    guide.guideName = [object objectForKey:@"name"];
    guide.guideCollectNums = [object objectForKey:@"collect_nums"];
    guide.guideCommentNums = [object objectForKey:@"comment_nums"];
    return guide;
}

- (GuideCategoryModel *)createGuideCategoryModel:(NSDictionary *)object
{
    GuideCategoryModel *guideCategory = [[GuideCategoryModel alloc] init];
    guideCategory.guideCategory = [object objectForKey:@"id"];
    guideCategory.guideCategoryId = [object objectForKey:@"category"];
    return guideCategory;
}



@end
