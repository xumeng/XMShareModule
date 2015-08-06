//
//  XMShareQQUtil.h
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

//  分享到QQ的类型
typedef NS_ENUM(NSInteger, SHARE_QQ_TYPE){
    
    //  QQ会话
    SHARE_QQ_TYPE_SESSION,
    
    //  QQ空间
    SHARE_QQ_TYPE_QZONE
    
};

@interface XMShareQQUtil : NSObject <TencentSessionDelegate>

@property (nonatomic, strong) NSString *shareTitle;

@property (nonatomic, strong) NSString *shareText;

@property (nonatomic, strong) NSString *shareUrl;


- (void)shareToQQ;

- (void)shareToQzone;

+ (instancetype)sharedInstance;

@end
