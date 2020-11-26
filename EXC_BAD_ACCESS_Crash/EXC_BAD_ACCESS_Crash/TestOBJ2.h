//
//  TestOBJ2.h
//  EXC_BAD_ACCESS_Crash
//
//  Created by mac_25648_newMini on 2020/11/25.
//

#import <Foundation/Foundation.h>

@protocol TestOBJ2Delegate <NSObject>

- (void)finish;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TestOBJ2 : NSObject

@property (weak,nonatomic) id<TestOBJ2Delegate> delegate;

- (void)start;

@end

NS_ASSUME_NONNULL_END
