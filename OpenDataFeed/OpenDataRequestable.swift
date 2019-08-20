//
//  OpenDataRequestable.swift
//  OpenDataFeed
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
protocol OpenDataRequestable: Requestable {}

extension OpenDataRequestable {
  /// 預設 isAuthorizedRequest 為 false
  var isAuthorizedRequest: Bool { return false }
  
  /// oauthToken 預設為 nil
  var oauthToken: [String : String]? { return nil }
  
  /// api 文件中沒有指定 api key, 預設改為空字串
  var apikey: [String : String]? { return ["apikey": ""] }
  
  /// 根據 api 文件指定所有 request 的共同 url 路徑
  var baseURL: URL {
    return URL(string: "https://data.taipei/opendata/datalist")!
  }
  
  /// 預設沒有 queryFields
  var queryFields: [String : Any] {
    return [:]
  }
  
  /// 預設沒有 query parameters
  var queryParameters: [String : Any] {
    return [:]
  }
}
