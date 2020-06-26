//
//  main.m
//  TestMessageSending
//
//  Created by 陈鑫亮 on 2020/6/26.
//  Copyright © 2020 陈鑫亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        Dog *dog = [[Dog alloc] init];
        [dog talk];
        [dog callBaaBaa];
        [dog callMeowMeow];
        
    }
    return 0;
}
