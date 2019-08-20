//
//  Requestable.swift
//  API Exercise
//
//  Created by Paul Lee on 2018/9/10.
//  Copyright © 2018 Paul Lee. All rights reserved.
//

import Foundation

/// 所有被送到後台的 http request 都會遵循這個 protocol
public protocol Requestable {
  
  /// request 成功後, 從回傳的 data decode 之後的物件, 該物件要遵循 Decodable 協議
  associatedtype Obj: Decodable
  
  /// request 的共同 URL 路徑
  var baseURL: URL { get }
  
  /// request 的個別 URL 路徑
  var path: String? { get }
  
  /// 是否為需要被授權的 request, 如果是, oauthToken 不可為 nil
  var isAuthorizedRequest: Bool { get }
  
  /// request 通常夾帶在 header 中的 api key
  var apikey: [String: String]? { get }
  
  /// request 需要的令牌
  var oauthToken: [String: String]? { get }
  
  /// request 的 header
  var headerField: [String: String] { get }
  
  /// request 的 http method
  var httpMethod: HTTPMethod { get }
  
  /// request 所需要攜帶的資料
  var httpBody: Data? { get }
  
  /// request 的路徑中需要填入的欄位, 例如 user/{id}/followers
  var queryFields: [String: Any] { get }
  
  /// request 結尾需要填入的欄位, 例如 /products?id=99
  var queryParameters: [String: Any] { get }
  
  /// 將 request 內攜帶的所有資訊 (url, header, httpBody ... etc) 轉換成
  /// URL request 的 function, 透過 protocol extension 有預設的實作, 但實際上
  /// 還是可能需要根據 api 文件來調整實作
  func makeURLRequest() -> URLRequest
  
}


// MARK: - Requestable 的預設實作
public extension Requestable {
  
  /// 預設 header 沒有任何資料
  var headerField: [String: String] {
    return [:]
  }
  
  
  /// 預設 httpBody 沒有任何資料
  var httpBody: Data? {
    return nil
  }
  
  
  /// makeURLRequest 的預設實作, 會將 apikey 或 oauth token 打包進 header, 預設 isAuthorizedRequest
  /// 為 true 的 request 一定要有 oauth token, 若為 false 也會強制要求有 api key。此預設實作可依照 api 文件調整。
  ///
  /// - Returns: 攜帶 request 所以資訊的 URLRequest
  func makeURLRequest() -> URLRequest {
    
    var fullURL: URL
    
    if let path = path {
      let filledPath = path.fill(with: queryFields)
      fullURL = baseURL.appendingPathComponent(filledPath)
      
    } else {
      fullURL = baseURL
      
    }
    
    var urlRequest = URLRequest(url: fullURL)
    //urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
    urlRequest.httpMethod = httpMethod.rawValue
    
    if isAuthorizedRequest {
      guard let token = oauthToken else {
        fatalError("authorized request should have non nil oauth token, please check the implementation for your request")
      }
      
      token.forEach { (key, value) in
        urlRequest.addValue(value, forHTTPHeaderField: key)
      }
      
    } else {
      guard let apiKey = apikey else {
        fatalError("non authorized request should have non nil api key, please check the mplementation for your request")
      }
      
      apiKey.forEach { (key, value) in
        urlRequest.addValue(value, forHTTPHeaderField: key)
      }

    }
    
    headerField.forEach { key, value in
      urlRequest.addValue(value, forHTTPHeaderField: key)
    }
    
    if let body = httpBody {
      urlRequest.httpBody = body
    }
    
    guard var urlComponents = URLComponents(url: fullURL, resolvingAgainstBaseURL: true) else {
      return urlRequest
    }
    
    guard queryParameters.count > 0 else {
      return urlRequest
    }
    
    urlComponents.query = queryParameters
      .map { "\($0.key)=\($0.value)" }
      .joined(separator: "&")

    urlRequest.url = urlComponents.url
    
    return urlRequest
  }
}


