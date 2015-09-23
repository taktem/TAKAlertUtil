//
//  TAKAlertView.swift
//  TAKAlertUtil
//
//  Created by 西村 拓 on 2015/09/16.
//  Copyright © 2015年 TakuNishimura. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class TAKAlertView: NSObject {
    let alertView = UIAlertView()
    
    func showWithTitle(
        title title: String,
        message: String,
        buttonTitles: [String]) -> Observable<Int> {
        
    }
    
    
    
        /**
        *  アラート表示
        *
        *  @param title        タイトル
        *  @param message      本文
        *  @param buttonTitles ボタンタイトル配列
        */
//        + (void)showWithTitle:(NSString *)title
//    message:(NSString *)message
//    buttonTitles:(NSArray *)buttonTitles
//    buttonHandler:(void (^)(UIAlertView*alertView, NSInteger index))buttonHandler;
//}
