//
//  XMShareWechatUtil.h
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XMShareWechatUtil : NSObject

@property (nonatomic, strong) NSString *shareTitle;

@property (nonatomic, strong) NSString *shareText;

@property (nonatomic, strong) NSString *shareUrl;


- (void)shareToWeixinSession;

- (void)shareToWeixinTimeline;

+ (instancetype)sharedInstance;

@end
