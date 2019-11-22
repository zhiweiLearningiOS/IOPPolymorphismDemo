//
//  IOPPolymorphismProtocol.h
//  IOP_PolymorphismDemo
//
//  Created by luozhiwei on 2019/11/22.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIView;

@protocol ChildHandlerProtocol <NSObject>

@required   // 必要复写方法
- (void)laudActionWithToastView:(UIView *)toastView;

@optional   // 必要复写方法

@end

@protocol InterceptorHandlerProtocol <NSObject>

@required   // 必要复写方法

@optional   // 必要复写方法
- (BOOL)playActionWithToastView:(UIView *)toastView;

@end


@protocol IOPPolymorphismProtocol <NSObject>

@property (nonatomic, strong) id <ChildHandlerProtocol> child;
@property (nonatomic, strong) id <InterceptorHandlerProtocol> interceptor;

@end
