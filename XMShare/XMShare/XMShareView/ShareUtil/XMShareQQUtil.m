//
//  XMShareQQUtil.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "XMShareQQUtil.h"

@implementation XMShareQQUtil



- (void)shareToQQ
{
    
    [self shareToQQBase:SHARE_QQ_TYPE_SESSION];
    
}

- (void)shareToQzone
{
    
    [self shareToQQBase:SHARE_QQ_TYPE_QZONE];
    
}

- (void)shareToQQBase:(SHARE_QQ_TYPE)type
{
    
    TencentOAuth *tencentOAuth = [[TencentOAuth alloc] initWithAppId:APP_KEY_QQ andDelegate:self];
    NSLog(@"TencentOAuth accessToken:%@", tencentOAuth.accessToken);
    
    NSString *utf8String = self.shareUrl;
    NSString *theTitle = self.shareTitle;
    NSString *description = self.shareText;
    NSData *imageData = UIImageJPEGRepresentation(SHARE_IMG, SHARE_IMG_COMPRESSION_QUALITY);
    
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:utf8String]
                                title:theTitle
                                description:description
                                previewImageData:imageData];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    
    if (type == SHARE_QQ_TYPE_SESSION) {
        
        //将内容分享到qq
        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
        NSLog(@"QQApiSendResultCode:%d", sent);
        
    }else{
        
        //将内容分享到qzone
        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
        NSLog(@"Qzone QQApiSendResultCode:%d", sent);
        
    }
}


+ (instancetype)sharedInstance
{
    
    static XMShareQQUtil* util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        util = [[XMShareQQUtil alloc] init];
        
    });
    return util;
    
}

- (instancetype)init
{
    
    static id obj=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        obj = [super init];
        
        if (obj) {
            
        }
    });
    self=obj;
    return self;
}

@end
