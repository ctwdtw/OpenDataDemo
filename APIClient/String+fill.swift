//
//  String+fill.swift
//  API Exercise
//
//  Created by Paul Lee on 2018/9/11.
//  Copyright © 2018 Paul Lee. All rights reserved.
//

/**
 此檔案時實作兩個 String 的 extension function, 兩個 function 的功能完全一樣,
 但可傳入的參數不同
 
*/
import Foundation
extension String {
  
  /// 用來填滿 request 路徑中的欄位, 待填滿的欄位會用
  /// {field} 來表示, 例如 /user/{id}
  ///
  /// - Parameter queryFiels: 表示待填欄位的 dictionary, key 為欄位名稱, vlaue 為欄位的值, 欄位的值不限字串, 但最後
  /// 會被轉成字串表現
  /// - Returns: 用欄位值填滿欄位後的字串
  func fill(with queryFiels: [String: Any]) -> String {
    var finalString = self
    queryFiels.forEach { (key, value) in
      finalString = finalString.replacingOccurrences(of: "{\(key)}", with: "\(value)")
    }
    return finalString
  }
}

extension String {
  
  /// 用來填滿字串中的 place holder, place holder 的形式會是 {placaholder}
  /// 例如 "hello {guestName}"
  ///
  /// - Parameter placeholders: 表示待填 place holder 的 dictionary, key 為 place holder, value 為待
  /// 填入的字串
  /// - Returns: 用字串填滿 place holder 之後的字串
  func fill(with placeholders: [String: String]) -> String {
    var finalString = self
    placeholders.forEach { (key, value) in
      finalString = finalString.replacingOccurrences(of: "{\(key)}", with: "\(value)")
    }
    return finalString
  }
}
