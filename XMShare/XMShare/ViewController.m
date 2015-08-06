//
//  ViewController.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "ViewController.h"
#import "XMShareView.h"

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
}

@end
