//
//  PlayerNoNetworkStateHandler.m
//  IOP_PolymorphismDemo
//
//  Created by luozhiwei on 2019/11/22.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import "PlayerNoNetworkStateHandler.h"
#import <UIKit/UIKit.h>
#import <UIView+Toast.h>

@implementation PlayerNoNetworkStateHandler

#pragma mark - ChildHandlerProtocol

- (void)laudActionWithToastView:(UIView *)toastView
{
    [toastView makeToast:@"网络不佳，请稍后再试"];
}

#pragma mark - InterceptorHandlerProtocol

- (BOOL)playActionWithToastView:(UIView *)toastView
{
    [toastView makeToast:@"网络不佳，请稍后再试"];
    
    return NO;
}

@end
