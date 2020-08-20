//
//  TPViewController.m
//  TPMessageAlert
//
//  Created by zhaotianpeng on 08/19/2020.
//  Copyright (c) 2020 zhaotianpeng. All rights reserved.
//

#import "TPViewController.h"
#import "TPMessageAlert.h"

@interface TPViewController ()

@end

@implementation TPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)createUI
{
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 200, 200, 100)];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(10, 400, 200, 100)];
    [btn1 setTitle:@"点我出现一个按钮" forState:UIControlStateNormal];
    [btn2 setTitle:@"点我出现两个按钮" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
}

- (void)btn1Action
{
    [TPMessageAlert showTitle:@"标题" DetailMsg:@"副标题" LeftItem:@"确定" RightItem:nil LeftAction:^{
        NSLog(@"确定");
    } RightAction:nil];
}

- (void)btn2Action
{
    [TPMessageAlert showTitle:@"标题" DetailMsg:@"副标题" LeftItem:@"确定" RightItem:@"取消" LeftAction:^{
        NSLog(@"确定");
    } RightAction:^{
        NSLog(@"取消");
    }];
}

@end
