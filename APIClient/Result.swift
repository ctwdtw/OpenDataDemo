//
//  Result.swift
//  API Exercise
//
//  Created by Paul Lee on 2018/9/10.
//  Copyright © 2018 Paul Lee. All rights reserved.
//

/**
 Result 物件, Swift 5.0 之後有內建
 
*/

import Foundation
public enum Result<T, E> {
  
  /// 成功, 會攜帶成功時回傳的物件
  case success(T)
  
  /// 失敗, 繪會攜帶失敗時回傳的錯誤
  case failed(E)
  
  /// 成功時回傳的物件
  public var value: T? {
    switch self {
    case .success(let value):
      return value
    
    default:
      return nil
    
    }
  }
  
  /// 失敗時回傳的錯誤
  public var error: E? {
    switch self {
    case .failed(let error):
      return error
    
    default:
      return nil
    
    }
  }
  
  /// Result 是否成功
  var isSuccess: Bool {
    switch self {
    case .success(_):
      return true
    
    case .failed(_):
      return false
    
    }
  }
  
}
