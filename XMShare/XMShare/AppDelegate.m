//
//  AppDelegate.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonMarco.h"

#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self init3rdParty];
    
    
    return YES;
}

/**
 *  初始化第三方组件
 */
- (void)init3rdParty
{
    [WXApi registerApp:APP_KEY_WEIXIN];
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:APP_KEY_WEIBO];
    
}


@end
