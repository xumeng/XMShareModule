# ReadMe
为了方便第三方开发者快速简单的集成国内三大社交平台（微信，QQ，微博），故造此轮子。

*`目前支持微信（微信好友，微信朋友圈），QQ，QQ空间，新浪微博）`*

关于此模块的Bug反馈、建议、口水等等，请大家狠拍并提交到Github上，我会尽快解决。

该模块会继续完善优化，争取为大家提供一个更快速、更简单、更规范、扩展性更好的集成模块。

===========
![图片](http://i1.tietuku.com/d62804985316df60.gif)

# 特点：
* 快速
* 简单
* 易集成
* 支持网页/SSO
* 扩展性好
* 可定制

===

# 更新 Log
    * 2015-09-29 修复网页微博分享时内容没有传入的 Bug
    * 2015-10-29 适配 iOS 9 下分享
    * 2015-11-04 新增三大平台分享后的回调
    * 2016-01-11 新增适配 iOS 9 SSO 的 `LSApplicationQueriesSchemes`配置说明


# 集成步骤
### 1. 下载微信、QQ、微博的社交sdk并导入至项目中

* *可在本页下方参考资料中取得*

### 2. 导入它们所需的系统framework与库
程序 —— Targets —— Build Phases —— Link Binary With Libraries

`Security.framework`, `SystemConfiguration.framework`, `CoreGraphics.framework`, `CoreTelephony.framework`, `QuartzCore.framework`, `ImageIO.framework`, `CoreText.framework`, `UIKit.framework`, `Foundation.framework`, `libsqlite3.dylib`, `libc++.dylib`, `libz.dylib`, `libstdc++.dylib`, `libiconv.dylib`

* *(具体可参考本页底部参考资料链接)*


### 3. 设置编译选项
程序 —— Targets —— Build Settings —— Linking —— Other Linker Flag 添加 `-ObjC`


### 4. 设置URL Schema
1. 程序 —— Targets —— Info —— URL Types

分别添加微信，QQ，微博

`tencentopenapi` : `tencent222222`

`mqqapi` : `QQ0605C97A`

`weibo` : `wb2045436852`

`weixin` : `wxd930ea5d5a258f4f`

* *以上均为测试app key，具体可以去对应的开放平台注册*

* *mqqapi 是 tencent 的 app key 转十六进制，不足八位在前面补 0 的结果*


2. 在 Info.plist 中添加`LSApplicationQueriesSchemes`项，
分别添加社交平台的几个白名单：
mqq
mqqopensdkapiV2
mqqapi
weibosdk2.5
weibosdk
weibo
weixin
wechat

具体列表请至获取[iOS 9 应用跳转适配](http://dev.umeng.com/social/ios/ios9)



### 5. 导入XMShareView至项目中

#####XMShareView结构介绍：
名称            | 解释
---            | ---
CommonMarco.h  | 通用宏文件，包含APP Key等宏
ExtView/       | 扩展View，VerticalUIButton为图片文件垂直对齐按钮
Resource/      | 图片等资源，包含微信、QQ、微博图标
ShareUtil/     | 分享工具类
XMShareView.h  | 分享显示视图



### 6. 在AppDelegate.m中注册
1. 导入文件头

```
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
```

2. 在 `application -> didFinishLaunchingWithOptions` 方法中注册

```
[WXApi registerApp:APP_KEY_WEIXIN];
[WeiboSDK enableDebugMode:YES];
[WeiboSDK registerApp:APP_KEY_WEIBO];
```

### 7. 在`ViewController.m` 中引用

* 导入文件头
 
	```
	#import "XMShareView.h"
	```

* 添加一个属性

```
@property (nonatomic, strong) XMShareView *shareView;
```

* 在点击分享的方法添加如下代码：
 
```
   if(!self.shareView){
        
        self.shareView = [[XMShareView alloc] initWithFrame:self.view.bounds];
        
        self.shareView.alpha = 0.0;

        self.shareView.shareTitle = NSLocalizedString(@"分享标题", nil);
        
        self.shareView.shareText = NSLocalizedString(@"分享内容", nil);
        
        self.shareView.shareUrl = @"http://xumeng.github.com";
        
        [self.view addSubview:self.shareView];
        
        [UIView animateWithDuration:1 animations:^{
            self.shareView.alpha = 1.0;
        }];
        
        
    }else{
        [UIView animateWithDuration:1 animations:^{
            self.shareView.alpha = 1.0;
        }];
        
    }

```

### 8. 处理 URL 跳转
####在 `AppDelegate` 类中实现两个处理 URL 跳转的方法。
```
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        
//        return [TencentOAuth HandleOpenURL:url];
        return [QQApiInterface handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }else if([[url absoluteString] hasPrefix:@"wx"]) {

        //  处理微信回调需要在具体的 ViewController 中处理。
        ViewController *vc = (ViewController *)self.window.rootViewController;
        return [WXApi handleOpenURL:url delegate:vc];
        
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url absoluteString] hasPrefix:@"tencent"]) {
        
        return [TencentOAuth HandleOpenURL:url];
        
    }else if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }else{
        
        ViewController *vc = (ViewController *)self.window.rootViewController;
        return [WXApi handleOpenURL:url delegate:vc];
        
    }
}

```

### 9. 处理分享后的回调
***特别提醒：（下方方法体内是示例代码，具体业务逻辑请具体实现）***
* 微信分享：在具体的调用 ViewController 类里面实现微信 `WXApiDelegate` 协议，然后实现以下方法：

```
- (void)onResp:(BaseResp *)resp
{
    NSString *message;
    if(resp.errCode == 0) {
        message = @"分享成功";
    }else{
        message = @"分享失败";
    }
    showAlert(message);
}
```

* QQ 分享：在 `AppDelegate` 类中实现 `QQApiInterfaceDelegate` 协议，然后实现以下方法：

```
- (void)onResp:(QQBaseResp *)resp
{
    NSString *message;
    if([resp.result integerValue] == 0) {
        message = @"分享成功";
    }else{
        message = @"分享失败";
    }
    showAlert(message);
}
```

* 微博分享：在 `AppDelegate` 类中实现 `WeiboSDKDelegate` 协议，然后实现以下方法：

```
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSString *message;
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
            message = @"分享成功";
            break;
        case WeiboSDKResponseStatusCodeUserCancel:
            message = @"取消分享";
            break;
        case WeiboSDKResponseStatusCodeSentFail:
            message = @"分享失败";
            break;
        default:
            message = @"分享失败";
            break;
    }
    showAlert(message);
}
```


# 参考资料
[QQ iOS SDK 环境搭建](http://wiki.connect.qq.com/ios_sdk%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA)

[新浪微博 iOS SDK 环境搭建](https://github.com/sinaweibosdk/weibo_ios_sdk/blob/master/%E5%BE%AE%E5%8D%9AiOS%E5%B9%B3%E5%8F%B0SDK%E6%96%87%E6%A1%A3V3.1.1.pdf)

[微信 iOS SDK 环境搭建](https://open.weixin.qq.com/cgi-bin/showdocument?action=dir_list&t=resource/res_list&verify=1&id=1417694084&token=&lang=zh_CN)

[iOS 9 适配 SSO](http://dev.umeng.com/social/ios/ios9)