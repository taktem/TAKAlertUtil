//
//  TAKAlertController.m
//
//  Created by 西村 拓 on 2015/07/26.
//  Copyright (c) 2015年 TakuNishimura. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "TAKAlertController.h"

@interface TAKAlertController ()

/// ボタンコールバック保持用
@property (copy, nonatomic) void (^clickButtonBlock)(id, NSInteger);

/// アラート表示のベースとなるWindow
@property (strong, nonatomic) UIWindow *window;

/// Retainカウント保持用に、自分を強参照
@property (strong, nonatomic) TAKAlertController *strongSelf;

@end

@implementation TAKAlertController

/**
 *  init
 *
 *  @param title         タイトル
 *  @param message       メッセージ
 *  @param buttonTitles  ボタンタイトル配列
 *  @param buttonHandler ボタン押下時のコールバック
 *
 *  @return TAKAlertController
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                 buttonTitles:(NSArray *)buttonTitles
                buttonHandler:(void (^)(UIAlertController*alertController, NSInteger index))buttonHandler {
    self = [TAKAlertController alertControllerWithTitle:title
                                                message:message
                                         preferredStyle:UIAlertControllerStyleAlert];
    if (self) {
        for (int i = 0; i<buttonTitles.count; i++) {
            NSString *buttonTitle = buttonTitles[i];
            [self addAction:[self addActionWithTitle:buttonTitle index:i]];
        }
        
        self.strongSelf = self;
        self.clickButtonBlock = buttonHandler;
    }
    
    return self;
}

/**
 *  タイトルとインデックスを指定してボタンアクションを追加する
 *
 *  @param title タイトル
 *  @param index インデックス
 *
 *  @return UIAlertAction
 */
- (UIAlertAction *)addActionWithTitle:(NSString *)title
                                index:(int)index {
    __weak typeof(self) weakSelf = self;
    return [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (self.clickButtonBlock) {
            self.clickButtonBlock(weakSelf, index);
        }
        
        weakSelf.strongSelf = nil;
        
        // 用済みのWindowをころす
        [weakSelf.window.rootViewController.view removeFromSuperview];
        weakSelf.window.rootViewController = nil;
        
        // 制御をアプリケーションメインWindowに戻す
        [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
        
        weakSelf.window = nil;
    }];
}

/**
 *  アラート表示
 *
 *  @param title        タイトル
 *  @param message      本文
 *  @param buttonTitles ボタンタイトル配列
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
         buttonTitles:(NSArray *)buttonTitles
        buttonHandler:(void (^)(UIAlertController*alertController, NSInteger index))buttonHandler {
    /** メッセージ指定の汎用エラー **/
    TAKAlertController *alert = [[TAKAlertController alloc]initWithTitle:title
                                                     message:message
                                                buttonTitles:buttonTitles
                                               buttonHandler:buttonHandler];
    
    alert.strongSelf = alert;
    
    [alert show];
}

/**
 *  アラート用にWindowを別生成し、表示
 */
- (void)show {
    // オーバーレイWindowのメインRootを用意
    UIViewController *controller = [UIViewController new];
    
    // アラート用のWindowを生成してアクティベート
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.rootViewController = controller;
    
    [self.window makeKeyAndVisible];

    // Show
    [self.window.rootViewController presentViewController:self animated:YES completion:^{
        
    }];
}

@end