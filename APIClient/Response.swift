//
//  Response.swift
//  janitorapp
//
//  Created by Paul Lee on 2019/3/11.
//  Copyright © 2019 Paul Lee. All rights reserved.
//

import Foundation


/// APISession send request 之後, 得到的回應資料所封裝成的物件,
/// 封裝的資料包含了 data, httpUrlResponse, error, 和原本 request 的參數
public struct Response<T:Requestable> {
  
  ///原本的 request, 包含對後台送出的所有參數
  var request: T
  
  ///後台回應的 HTTPURLResponse
  var response: HTTPURLResponse?
  
  /// 後台回應的 data
  var data: Data?
  
  /// 後台回應的 Result, 包含了由 data decode 之後的物件, 或是 request 失敗後的 error
  var result: Result<T.Obj, Error>
  
  ///建構子, 吃進後台回傳的資料封裝成 Response 物件
  init(request: T, data: Data?, response: HTTPURLResponse?, result: Result<T.Obj, Error>) {
    self.request = request
    self.response = response
    self.result = result
    
  }
}
