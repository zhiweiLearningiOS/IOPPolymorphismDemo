//
//  PlayerBannedStateHandler.h
//  IOP_PolymorphismDemo
//
//  Created by luozhiwei on 2019/11/22.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOPPolymorphismProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayerBannedStateHandler : NSObject <ChildHandlerProtocol,InterceptorHandlerProtocol>

@end

NS_ASSUME_NONNULL_END
