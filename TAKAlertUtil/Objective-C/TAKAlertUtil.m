//
//  TAKAlertUtil.m
//
//  Created by 西村 拓 on 2015/07/10.
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

#import "TAKAlertUtil.h"

#import "TAKAlertView.h"
#import "TAKAlertController.h"

@interface TAKAlertUtil()

/// Retainカウント保持用に、自分を強参照
@property (strong, nonatomic) TAKAlertUtil *strongSelf;

/// コールバック参照保持用
@property (strong, nonatomic) id<RACSubscriber> subscriber;

@end

@implementation TAKAlertUtil

#pragma mark - Cycle
/**
 *  両OS共通でコールバックを受けつける役割
 *  subscriveされてる場合はここからRACSubscriberへの通知を送る
 *
 *  @param alert       対象Alert（UIAlertView or UIAlertController)
 *  @param buttonIndex 押下されたボタンインデックス
 */
- (void)alertCallBack:(id)alert clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.subscriber sendNext:@(buttonIndex)];
    [self.subscriber sendCompleted];
}

#pragma mark - Control
/**
 *  アラート表示、両OS共通部。
 *  ここからiOS8前後で分岐し、UIAlertViewかUIAlertControllerかを判別する
 *
 *  @param title        タイトル
 *  @param message      本文
 *  @param buttonTitles ボタンタイトル配列
 */
+ (RACSignal *)showWithTitle:(NSString *)title
                     message:(NSString *)message
                buttonTitles:(NSArray *)buttonTitles {
    
    
    TAKAlertUtil *alert = [TAKAlertUtil new];
    
    // 8.0以上はAlert Controllerを使う
    if ([UIAlertController class]) {
        return [alert showAlertControllerWithTitle:title
                                           message:message
                                      buttonTitles:buttonTitles];
    } else {
        return [alert showAlertViewWithTitle:title
                                     message:message
                                buttonTitles:buttonTitles];
    }
}

/**
 *  iOS8未満 AlertViewを使う
 *
 *  @param title        タイトル
 *  @param message      メッセージ
 *  @param buttonTitles ボタンタイトル配列
 *
 *  @return RAC
 */
- (RACSignal *)showAlertViewWithTitle:(NSString *)title
                              message:(NSString *)message
                         buttonTitles:(NSArray *)buttonTitles {
    @weakify(self)
    
    self.strongSelf = self;
    [TAKAlertView showWithTitle:title
                        message:message
                   buttonTitles:buttonTitles
                  buttonHandler:^(UIAlertView *alertView, NSInteger index) {
                      @strongify(self)
                      [self alertCallBack:alertView clickedButtonAtIndex:index];
                      
                      self.strongSelf = nil;
                  }];
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        self.subscriber = subscriber;
        
        return [RACDisposable disposableWithBlock:^{
            @strongify(self)
            self.subscriber = nil;
        }];
    }];
}

/**
 *  iOS8移行 AlertControllerを使う
 *
 *  @param title        タイトル
 *  @param message      メッセージ
 *  @param buttonTitles ボタンタイトル配列
 *
 *  @return RAC
 */
- (RACSignal *)showAlertControllerWithTitle:(NSString *)title
                                    message:(NSString *)message
                               buttonTitles:(NSArray *)buttonTitles {
    @weakify(self)
    
    self.strongSelf = self;
    [TAKAlertController showWithTitle:title
                              message:message
                         buttonTitles:buttonTitles
                        buttonHandler:^(UIAlertController *alertController, NSInteger index) {
                            @strongify(self)
                            [self alertCallBack:alertController clickedButtonAtIndex:index];
                            
                            self.strongSelf = nil;
                        }];
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        self.subscriber = subscriber;
        
        return [RACDisposable disposableWithBlock:^{
            @strongify(self)
            self.subscriber = nil;
        }];
    }];
}

@end