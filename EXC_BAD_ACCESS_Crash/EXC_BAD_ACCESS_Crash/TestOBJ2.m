//
//  TestOBJ2.m
//  EXC_BAD_ACCESS_Crash
//
//  Created by mac_25648_newMini on 2020/11/25.
//

#import "TestOBJ2.h"

@implementation TestOBJ2

- (void)dealloc{
    NSLog(@"TestOBJ2 dealloc");
}

- (void)start{
    [self print:@"1"];
    [self.delegate finish];
    [self print:@"2"];
}

- (void)print:(NSString *)message{
    NSLog(message);
}

@end
