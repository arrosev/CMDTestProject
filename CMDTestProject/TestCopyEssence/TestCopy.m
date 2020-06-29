//
//  TestCopy.m
//  TestCopyEssence
//
//  Created by 陈鑫亮 on 2020/6/29.
//  Copyright © 2020 陈鑫亮. All rights reserved.
//

#import "TestCopy.h"

@interface TestCopy ()

@property(copy,nonatomic) NSMutableString *name;

@end

@implementation TestCopy

- (void)testCopy {
    NSMutableString *name = [NSMutableString stringWithFormat:@"王"];
    self.name = name;
    NSLog(@"%@",self.name);
    [name appendString:@"小二"];
    NSLog(@"%@",self.name);
}

@end
