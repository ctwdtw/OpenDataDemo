//
//  UIViewController+Alert.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/22.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
import UIKit
// MARK: - UIVIewController + Alert
extension UIViewController {
  
  /// 顯示只有單一一個確認按鈕的 alert
  ///
  /// - Parameters:
  ///   - title: alertController 的 title
  ///   - message: alertController 的 message
  ///   - okTitle: 確認按鈕的顯示文字, 預設為 R.Swfit 產生的本地化字串
  ///   - okHandler: 按下 okTitle 後執行的動作, 預設為 nil
  func showSimpleAlert(_ title: String?,
                       message: String? = nil,
                       okTitle: String = "OK",
                       okHandler: ((UIAlertAction) -> Void)? = nil,
                       completion: (() -> Void)? = nil) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
    alert.addAction(okAction)
    present(alert, animated: true, completion: completion)
  }
}

extension UIViewController {
  
  /// 顯示有確認和取消兩個按鈕的 alert
  ///
  /// - Parameters:
  ///   - title: alertController 的 title
  ///   - message: alertController 的 message
  ///   - okTitle: 確認按鈕的顯示文字, 預設為 R.Swfit 產生的本地化字串
  ///   - okHandler: 按下 okTitle 後執行的動作, 預設為 nil
  ///   - cancelTitle: 取消按鈕的顯示文字, 預設為 R.Swfit 產生的本地化字串
  ///   - cancelHandler: 按下 cancelTitle 後執行的動作, 預設為 nil
  ///   - completion: present alert 之後的動作, 預設為 nil
  func showTwoOptionsAlert(_ title: String?,
                           message: String?,
                           okTitle: String = "OK",
                           okHandler: ((UIAlertAction)->Void)? = nil,
                           cancelTitle: String = "Cancel",
                           cancelHandler: ((UIAlertAction) -> Void)? = nil,
                           completion: (()->Void)?) {
    
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
  
    let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
    let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelHandler)
    
    alert.addAction(cancelAction)
    alert.addAction(okAction)
    
    
    present(alert, animated: true, completion: completion)
  }
  
}

extension UIViewController {
  
  /// 顯示含有多個按鈕的 alert
  ///
  /// - Parameters:
  ///   - title: alertController 的 title
  ///   - message: alertController 的 message
  ///   - actions: alertController 可執行的所有動作
  func showAlert(_ title: String?, message: String?, actions: [UIAlertAction]) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    for action in actions {
      alert.addAction(action)
    }
    
    self.present(alert, animated: true)
    
  }
}

