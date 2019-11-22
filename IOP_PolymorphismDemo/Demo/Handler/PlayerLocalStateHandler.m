//
//  PlayerLocalStateHandler.m
//  IOP_PolymorphismDemo
//
//  Created by luozhiwei on 2019/11/22.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import "PlayerLocalStateHandler.h"
#import <UIKit/UIKit.h>
#import <UIView+Toast.h>

@implementation PlayerLocalStateHandler

#pragma mark - ChildHandlerProtocol

- (void)laudActionWithToastView:(UIView *)toastView
{
    [toastView makeToast:@"本地声音无法点赞"];
}

#pragma mark - InterceptorHandlerProtocol

- (BOOL)playActionWithToastView:(UIView *)toastView
{
    return YES;
}

@end
