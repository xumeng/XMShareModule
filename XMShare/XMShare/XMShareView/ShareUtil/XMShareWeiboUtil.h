//  微博分享工具类
//  XMShareWeiboUtil.h
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

#import "XMShareUtil.h"

@interface XMShareWeiboUtil : XMShareUtil


/**
 *  分享到微博
 */
- (void)shareToWeibo;

+ (instancetype)sharedInstance;

@end
