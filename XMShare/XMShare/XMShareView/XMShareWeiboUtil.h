//
//  XMShareWeiboUtil.h
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

@interface XMShareWeiboUtil : NSObject

@property (nonatomic, strong) NSString *shareTitle;

@property (nonatomic, strong) NSString *shareText;

@property (nonatomic, strong) NSString *shareUrl;

- (void)shareToWeibo;

+ (instancetype)sharedInstance;

@end
