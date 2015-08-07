//  微信分享工具类
//  XMShareWechatUtil.h
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "XMShareUtil.h"

@interface XMShareWechatUtil : XMShareUtil


/**
 *  分享到微信会话
 */
- (void)shareToWeixinSession;

/**
 *  分享到朋友圈
 */
- (void)shareToWeixinTimeline;

+ (instancetype)sharedInstance;

@end
