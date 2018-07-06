//
//  SZSingletonDelegate.h
//  AddTease
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#ifndef SZSingletonDelegate_h
#define SZSingletonDelegate_h

/**
 单例 遵循该协议
 */
@protocol SZSingletonDelegate <NSObject>

/**
 获取单例

 @return 单例
 */
+ (instancetype)sharedInstance;

@end

/**
 单例 使用宏 SZ_SINGLETON_DELEGATE 实现方法
 */
#define SZ_SINGLETON_DELEGATE static id instance = nil;\
\
+ (instancetype)sharedInstance {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [[[self class] alloc] init];\
});\
return instance;\
}

#endif /* SZSingletonDelegate_h */
