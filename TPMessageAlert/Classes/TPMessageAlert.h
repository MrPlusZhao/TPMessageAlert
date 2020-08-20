//
//  TPMessageAlert.h
//  TPMessageAlertDemo
//
//  Created by zhaotianpeng on 2020/8/18.
//  Copyright © 2020 zhaotianpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPMessageAlert : NSObject

/**
 * TPMessageAlert 工厂方法
 *
 * @param msg                  主标题
 * @param detailStr     副标题
 * @param leftStr         左边按钮标题
 * @param rightStr       右边按钮标题
 * @param leftAction                    左边按钮事件
 * @param rightAction                  右边按钮事件
 */

+ (void)showTitle:(NSString * _Nullable )msg
        DetailMsg:(NSString * _Nullable )detailStr
         LeftItem:(NSString * _Nullable )leftStr
        RightItem:(NSString * _Nullable )rightStr
       LeftAction:(_Nullable dispatch_block_t)leftAction
      RightAction:(_Nullable dispatch_block_t)rightAction;

@end

NS_ASSUME_NONNULL_END
