//
//  MyModal.h
//  winter
//
//  Created by command.Zi on 15/4/13.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

#define S_PROPERTY(__TYPE,__NAME) @property (strong, nonatomic) __TYPE *__NAME;

@interface MyModal : NSObject

@end

@interface GuideModel : BaseModel

S_PROPERTY(NSString, guideId)

S_PROPERTY(NSString, guideTitle)

S_PROPERTY(NSString, guideName)

S_PROPERTY(NSString, guideImage)

S_PROPERTY(NSString, guideTime)

S_PROPERTY(NSString, guideCollectNums)

S_PROPERTY(NSString, guideLikeNums)

S_PROPERTY(NSString, guideCommentNums)
@end

@interface GuideCategoryModel : BaseModel

S_PROPERTY(NSString, guideCategoryId)

S_PROPERTY(NSString, guideCategory)
@end
