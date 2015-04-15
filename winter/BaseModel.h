//
//  BaseModel.h
//  winter
//
//  Created by command.Zi on 15/4/13.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ENCODE_OBJECT(__CODER, __OBJECT,__KEY) [__CODER encodeObject:__OBJECT forKey:__KEY];

#define DECODE_OBJECT(__CODER,__KEY) [__CODER decodeObjectForKey:__KEY];

#if __has_feature(objc_instancetype)
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;
#undef	DEF_SINGLETON
#define DEF_SINGLETON \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{\
if ([self respondsToSelector:@selector(initWithNibName:bundle:)]) {\
__singleton__ = [[self alloc] initWithNibName:NSStringFromClass(self) bundle:nil];\
}\
if(!__singleton__){__singleton__ = [[self alloc] init];} } ); \
return __singleton__; \
}
#else
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{\
if ([[self class] respondsToSelector:@selector(initWithNibName:bundle:)]) {\
__singleton__ = [[[self class] alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];\
}\
if(!__singleton__){__singleton__ = [[[self class] alloc] init];} } ); \
return __singleton__; \
}
#endif


@interface BaseModel : NSObject<NSCoding>

AS_SINGLETON()

@end
