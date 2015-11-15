//
//  TAKAlertView.m
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

#import "TAKAlertView.h"

@interface TAKAlertView()<UIAlertViewDelegate>

/// ボタンコールバック保持用
@property (copy, nonatomic) void (^clickButtonBlock)(id, NSInteger);

/// Retainカウント保持用に、自分を強参照
@property (strong, nonatomic) TAKAlertView *strongSelf;

@end

@implementation TAKAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                 buttonTitles:(NSArray *)buttonTitles
                buttonHandler:(void (^)(UIAlertView*alertView, NSInteger index))buttonHandler {
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    if(self){
        for (NSString *buttonTitle in buttonTitles) {
            [self addButtonWithTitle: buttonTitle];
        }
        self.strongSelf = self;
        self.clickButtonBlock = buttonHandler;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(self.clickButtonBlock){
        self.clickButtonBlock(alertView,buttonIndex);
    }
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
         buttonTitles:(NSArray *)buttonTitles
        buttonHandler:(void (^)(UIAlertView*alertView, NSInteger index))buttonHandler {
    /** メッセージ指定の汎用エラー **/
    TAKAlertView *alert = [[TAKAlertView alloc]initWithTitle:title
                                                     message:message
                                                buttonTitles:buttonTitles
                                               buttonHandler:buttonHandler];
    
    [alert show];
}

@end
