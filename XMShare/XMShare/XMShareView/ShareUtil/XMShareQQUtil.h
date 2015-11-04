//  QQ分享工具类
//  XMShareQQUtil.h
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

#import "XMShareUtil.h"

//  分享到QQ的类型
typedef NS_ENUM(NSInteger, SHARE_QQ_TYPE){
    
    //  QQ会话
    SHARE_QQ_TYPE_SESSION,
    
    //  QQ空间
    SHARE_QQ_TYPE_QZONE
    
};

@interface XMShareQQUtil : XMShareUtil

/**
 *  分享到QQ会话
 */
- (void)shareToQQ;

/**
 *  分享到QQ空间
 */
- (void)shareToQzone;

+ (instancetype)sharedInstance;

@end
