//
//  SZSingletonDelegate.h
//  AddTease
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018年 Smooth. All rights reserved.
//

#ifndef SZSingletonDelegate_h
#define SZSingletonDelegate_h

@protocol SZSingletonDelegate <NSObject>

+ (instancetype)sharedInstance;

@end

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
