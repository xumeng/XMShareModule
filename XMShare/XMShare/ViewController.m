//
//  ViewController.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "ViewController.h"
#import "XMShareView.h"
#import "CommonMarco.h"

@interface ViewController ()

@property (nonatomic, strong) XMShareView *shareView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickShare:(id)sender {
    
    if(!self.shareView){
        
        self.shareView = [[XMShareView alloc] initWithFrame:self.view.bounds];
        
        self.shareView.alpha = 0.0;

        self.shareView.shareTitle = NSLocalizedString(@"分享标题", nil);
        
        self.shareView.shareText = NSLocalizedString(@"分享内容", nil);
        
        self.shareView.shareUrl = @"http://amonxu.com";
        
        [self.view addSubview:self.shareView];
        
        [UIView animateWithDuration:1 animations:^{
            self.shareView.alpha = 1.0;
        }];
        
        
    }else{
        [UIView animateWithDuration:1 animations:^{
            self.shareView.alpha = 1.0;
        }];
        
    }
}

#pragma mark - 代理回调
/**
 *  处理来自微信的请求
 *
 *  @param resp 响应体。根据 errCode 作出对应处理。
 */
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

@end
