//
//  Dog.m
//  TestMessageSending
//
//  Created by 陈鑫亮 on 2020/6/26.
//  Copyright © 2020 陈鑫亮. All rights reserved.
//

#import "Dog.h"
#import "Humanity.h"
#import "Sheep.h"
#import "Cat.h"
#import <objc/runtime.h>

@interface Dog () {
    Humanity *humanity;
    Sheep *sheep;
    Cat *cat;
}

@end

@implementation Dog

- (instancetype)init {
    self = [super init];
    if(self) {
        humanity = [[Humanity alloc] init];
        sheep = [[Sheep alloc] init];
        cat = [[Cat alloc] init];
    }
    return self;
}

#pragma private method

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if([NSStringFromSelector(sel) isEqualToString:@"talk"]) {
        //因为狗类没有实现talk方法，在动态方法解析时为狗类增加说话的此方法
        class_addMethod([self class], @selector(talk), class_getMethodImplementation([Humanity class], @selector(talk)),  "v@:");
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    //备用接收者羊处理消息
    if([NSStringFromSelector(aSelector) isEqualToString:@"callBaaBaa"]) {
        return sheep;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = [anInvocation selector];
    if([super respondsToSelector:sel]) {
        [super forwardInvocation:anInvocation];
    } else {
        [anInvocation invokeWithTarget:cat];//转发给猫类
    }
}

//- (BOOL)respondsToSelector:(SEL)aSelector {
//    if([self methodForSelector:aSelector] != (IMP)NULL) {
//        return YES;
//    }
//    if([super respondsToSelector:aSelector]) {
//        return YES;
//    }
//    if([cat respondsToSelector:aSelector]) {
//        return YES;
//    }
//    return NO;
//}

//重写methodSignatureForSelector,创建要转发的NSInvocation对象
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if([super respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    } else {
        return [cat methodSignatureForSelector:aSelector];
    }
}

@end
