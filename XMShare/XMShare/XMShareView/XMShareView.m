//
//  XMShareView.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "XMShareView.h"

#import "VerticalUIButton.h"
#import "CommonMarco.h"
#import "XMShareWeiboUtil.h"
#import "XMShareWechatUtil.h"
#import "XMShareQQUtil.h"

//  每一项的宽度
static const CGFloat itemWidth = 60.0;

//  每一项的高度
static const CGFloat itemHeight = 60.0;

//  水平间隔
static const CGFloat itemHorPadding = 20.0;

//  垂直间隔
static const CGFloat itemVerPadding = 20.0;


//  每行显示数量
static const NSInteger numbersOfItemInLine = 3;

@implementation XMShareView


- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configureData];
        [self initUI];
        
    }
    return self;
    
}

/**
 *  加载视图
 */
- (void)initUI
{
    
    //  背景色黑色半透明
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    //  点击关闭
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(clickClose)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
    CGFloat startY = 0;
    CGFloat bgViewWidth = itemWidth * numbersOfItemInLine + itemHorPadding * (numbersOfItemInLine + 1) ;
    CGFloat bgViewHeight = itemHeight * 2 + itemVerPadding * 4;
    CGFloat bgViewX = (SIZE_OF_SCREEN.width - bgViewWidth) / 2;
    CGFloat bgViewY = (SIZE_OF_SCREEN.height - bgViewHeight) / 2;
    
    //  居中白色视图
    UIView *shareActionView = [[UIView alloc] initWithFrame:CGRectMake(bgViewX,
                                                                       bgViewY,
                                                                       bgViewWidth,
                                                                       bgViewHeight)];
    ViewRadius(shareActionView, 2);
    shareActionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:shareActionView];
    
    for ( int i = 0; i < iconList.count; i ++ ) {
        
        VerticalUIButton *tempButton;
        UIImage *img = [UIImage imageNamed: iconList[i] ];
        
        int row = i / numbersOfItemInLine;
        
        int col = i % numbersOfItemInLine;
        
        CGFloat x =  (itemWidth + itemHorPadding) * col + itemHorPadding;
        
        CGFloat y = startY  + (itemHeight + itemVerPadding) * row + itemVerPadding;
        
        tempButton = [[VerticalUIButton alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeight)];
        tempButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [tempButton setImage:img forState:UIControlStateNormal];
        [tempButton setTitle:textList[i] forState:UIControlStateNormal];
        [tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tempButton addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if([textList[i] isEqualToString:NSLocalizedString(@"微信好友", nil)]){
            
            tempButton.tag = SHARE_ITEM_WEIXIN_SESSION;
            
        }else if([textList[i] isEqualToString:NSLocalizedString(@"朋友圈", nil)]){
            
            tempButton.tag = SHARE_ITEM_WEIXIN_TIMELINE;
            
        }else if([textList[i] isEqualToString:NSLocalizedString(@"QQ", nil)]){
            
            tempButton.tag = SHARE_ITEM_QQ;
            
        }else if([textList[i] isEqualToString:NSLocalizedString(@"QQ空间", nil)]){
            
            tempButton.tag = SHARE_ITEM_QZONE;
            
        }else if([textList[i] isEqualToString:NSLocalizedString(@"微博", nil)]){
            
            tempButton.tag = SHARE_ITEM_WEIBO;
            
        }
        
        [shareActionView addSubview:tempButton];
    }
   
}


/**
 *  初始化数据
 */
- (void)configureData
{
    
    /**
     *  判断应用是否安装，可用于是否显示
     *  QQ和Weibo分别有网页版登录与分享，微信目前不支持
     */
    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    //    BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    //    BOOL hadInstalledWeibo = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]];
    
    iconList = [[NSMutableArray alloc] init];
    textList = [[NSMutableArray alloc] init];
    
    if(hadInstalledWeixin){
        
        [iconList addObject:@"icon_share_wechat@2x"];
        [iconList addObject:@"icon_share_moment@2x"];
        [textList addObject:NSLocalizedString(@"微信好友", nil)];
        [textList addObject:NSLocalizedString(@"朋友圈", nil)];
        
    }
    
    //    if(hadInstalledQQ){
    
    [iconList addObject:@"icon_share_qq@2x"];
    [iconList addObject:@"icon_share_qzone@2x"];
    [textList addObject:NSLocalizedString(@"QQ", nil)];
    [textList addObject:NSLocalizedString(@"QQ空间", nil)];
    
    //    }
    
    //    if(hadInstalledWeibo){
    
    [iconList addObject:@"icon_share_webo@2x"];
    [textList addObject:NSLocalizedString(@"微博", nil)];
    
    //    }
    
}

- (void)clickActionButton:(VerticalUIButton *)sender
{
    
    if ( sender.tag == SHARE_ITEM_WEIXIN_SESSION ) {
        
        [self shareToWeixinSession];
        
    }else if ( sender.tag == SHARE_ITEM_WEIXIN_TIMELINE ) {
        
        [self shareToWeixinTimeline];
        
    }else if ( sender.tag == SHARE_ITEM_QQ ) {
        
        [self shareToQQ];
        
    }else if ( sender.tag == SHARE_ITEM_QZONE ) {
        
        [self shareToQzone];
        
    }else if ( sender.tag == SHARE_ITEM_WEIBO ) {
        
        [self shareToWeibo];
        
    }
    
    [self clickClose];
    
}

- (void)shareToWeixinSession
{
    
    XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    
    [util shareToWeixinSession];
    
}

- (void)shareToWeixinTimeline
{
    
    XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    
    [util shareToWeixinTimeline];
    
}

- (void)shareToQQ
{
    XMShareQQUtil *util = [XMShareQQUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    
    [util shareToQQ];
}

- (void)shareToQzone
{
    XMShareQQUtil *util = [XMShareQQUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    
    [util shareToQzone];
}

- (void)shareToWeibo
{
 
    XMShareWeiboUtil *util = [XMShareWeiboUtil sharedInstance];
    util.shareTitle = self.shareTitle;
    util.shareText = self.shareText;
    util.shareUrl = self.shareUrl;
    
    [util shareToWeibo];
    
}

- (void)clickClose
{
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0.0;
    }];
    
    
}


@end
