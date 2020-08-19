//
//  TPMessageAlert.m
//  TPMessageAlertDemo
//
//  Created by zhaotianpeng on 2020/8/18.
//  Copyright © 2020 zhaotianpeng. All rights reserved.
//

#import "TPMessageAlert.h"

# define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

@interface TPMessageAlert ()

@property (nonatomic, copy) dispatch_block_t leftActionBlock;
@property (nonatomic, copy) dispatch_block_t rightActionBlock;
@end

@implementation TPMessageAlert

+ (void)showTitle:(NSString * _Nullable )msg
        DetailMsg:(NSString * _Nullable )detailStr
         LeftItem:(NSString * _Nullable )leftStr
        RightItem:(NSString * _Nullable )rightStr
          Subview:(_Nonnull id)view
       LeftAction:(_Nullable dispatch_block_t)leftAction
      RightAction:(_Nullable dispatch_block_t)rightAction{
    
    TPMessageAlert *alert = [[TPMessageAlert alloc]init];
    [alert initTitle:msg DetailMsg:detailStr LeftItem:leftStr RightItem:rightStr Subview:view LeftAction:leftAction RightAction:rightAction];
}
- (void)initTitle:(NSString*)title
        DetailMsg:(NSString *)detailStr
         LeftItem:(NSString *)leftStr
        RightItem:(NSString *)rightStr
          Subview:(id)view
       LeftAction:(dispatch_block_t)leftAction
      RightAction:(dispatch_block_t)rightAction{
    if (leftAction) {
        self.leftActionBlock = leftAction;
    }
    if (rightAction) {
        self.rightActionBlock = rightAction;
    }
    
    if (![title length]) {
        title = @"title";
    }
    if (leftAction) {
        if (![leftStr length]) {
            leftStr = @"item01";
        }
    }
    if (rightAction) {
        if (![rightStr length]) {
            rightStr = @"item02";
        }
    }
    
    if (iOS9Later) {
        [self AlertControllerCreateForTPShowMessage:title DetailMsg:detailStr LeftItem:leftStr RightItem:rightStr VC:view];
    }
    else
    {
        [self AlertCreateForTPShowMessage:title DetailMsg:detailStr LeftItem:rightStr RightItem:leftStr];
        
    }
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)AlertCreateForTPShowMessage:(NSString *)msg
                          DetailMsg:(NSString *)detailStr
                           LeftItem:(NSString *)leftStr
                          RightItem:(NSString *)rightStr
{
    
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:msg message:detailStr delegate:self cancelButtonTitle:leftStr otherButtonTitles:rightStr, nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.leftActionBlock) {
            self.leftActionBlock();
        }
        
    }
    if (buttonIndex == 1) {
        if (self.rightActionBlock) {
            self.rightActionBlock();
        }
    }
}
#pragma clang diagnostic pop
- (void)AlertControllerCreateForTPShowMessage:(NSString *)msg
                                    DetailMsg:(NSString *)detailStr
                                     LeftItem:(NSString *)leftStr
                                    RightItem:(NSString *)rightStr
                                           VC:(id)view
{
    UIViewController *VC;
    if ([view isKindOfClass:[UIViewController class]]) {
        VC = (UIViewController*)view;
    }
    else if ([[view superclass] isEqual:[UIView class]]) {
        VC = [TPMessageAlert FatherViewControllerFromView:view];
        if (!VC) {
            NSLog(@"传入的类型错误");
            return;
        }
    }
    else{
        NSLog(@"传入的类型错误");
        return;
    }
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:msg message:detailStr preferredStyle:UIAlertControllerStyleAlert];
    if ([rightStr length]) {
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:rightStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.rightActionBlock) {
                self.rightActionBlock();
            }
        }];
        [alertVC addAction:action1];
        
    }
    if ([leftStr length]) {
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:leftStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (self.leftActionBlock) {
                self.leftActionBlock();
            }
        }];
        [alertVC addAction:action2];
        
    }
    [VC presentViewController:alertVC animated:YES completion:nil];
}
+ (UIViewController *)FatherViewControllerFromView:(UIView*)view
{
    UIView *next = view;
    while ((next = [next superview])) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
