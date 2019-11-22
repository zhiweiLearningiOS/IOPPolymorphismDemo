//
//  PlayerBannedStateHandler.m
//  IOP_PolymorphismDemo
//
//  Created by luozhiwei on 2019/11/22.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import "PlayerBannedStateHandler.h"
#import <UIKit/UIKit.h>
#import <UIView+Toast.h>

@implementation PlayerBannedStateHandler

#pragma mark - ChildHandlerProtocol

- (void)laudActionWithToastView:(UIView *)toastView
{
    [toastView makeToast:@"无法点赞，声音已被封禁"];
}

#pragma mark - InterceptorHandlerProtocol

- (BOOL)playActionWithToastView:(UIView *)toastView
{
    [toastView makeToast:@"无法播放，声音已被封禁"];
    
    return NO;
}

@end
