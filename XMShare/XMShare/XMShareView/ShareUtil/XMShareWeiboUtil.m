//
//  XMShareWeiboUtil.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "XMShareWeiboUtil.h"

@implementation XMShareWeiboUtil

- (void)shareToWeibo
{
    
    [self shareToWeiboBase];
    
}

- (void)shareToWeiboBase
{
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = APP_KEY_WEIBO_RedirectURL;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:nil];
    
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShare
{
    
    WBMessageObject *message = [WBMessageObject message];
    BOOL hadInstalledWeibo = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]];
    
    if(hadInstalledWeibo){
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = self.shareTitle;
        webpage.description = self.shareText;
        //  可改为自定义图片
        webpage.thumbnailData = UIImageJPEGRepresentation(SHARE_IMG, SHARE_IMG_COMPRESSION_QUALITY);
        webpage.webpageUrl = self.shareUrl;
        
        message.mediaObject = webpage;
    }
    
    message.text = [NSString stringWithFormat:@"%@ - %@ %@", self.shareTitle, self.shareText, self.shareUrl];
    
    
    return message;
    
}


+ (instancetype)sharedInstance
{
    
    static XMShareWeiboUtil* util;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        util = [[XMShareWeiboUtil alloc] init];
        
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