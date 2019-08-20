//
//  NetworkError.swift
//  janitorapp
//
//  Created by Paul Lee on 2019/3/12.
//  Copyright © 2019 Paul Lee. All rights reserved.
//

import Foundation

/// API localized 字串的 key
enum APIString: String {
  /// 後台沒有回應
  case noResponse
  
  /// 後台沒有吐回任何資料
  case noData
  
  /// 後台回應了不在 api 規格中的 JSON 資料, 通常可能發生在 api 改版的時候
  case unexpectedJSON
  
  /// 其他可能的錯誤
  case unexpectedError
}

/// API localized string
func apiLocString(id: APIString) -> String {
  return NSLocalizedString(id.rawValue, tableName: "API", comment: "")
}

/// 不在 janitor api 預期範圍內的連線錯誤
enum APIClientError: Error {
  /// 後台沒有回應
  case noResponse
  
  /// 後台沒有吐回任何資料
  case noData
  
  /// 後台回應了不在 api 規格中的 JSON 資料, 通常可能發生在 api 改版的時候
  case unexpectedJSON(httpStatusCode: Int, json: Any)
  
  /// 其他可能的錯誤
  case unexpectedError(httpStatusCode: Int, dataString: String?)
}

extension APIClientError: LocalizedError {
  
  /// 本地化字串
  var errorDescription: String? {
    switch self {
    case .noResponse:
      return apiLocString(id: .noResponse)
    
    case .noData:
      return apiLocString(id: .noData)
    
    case .unexpectedJSON(let httpStatusCode, let json):
      return apiLocString(id: .unexpectedJSON) + "\(httpStatusCode), \(json)"
      
    case .unexpectedError(let httpStatusCode, let dataString):
      if let dataString = dataString {
        return apiLocString(id: .unexpectedError) + "\(httpStatusCode), \(dataString)"
      
      } else {
        return apiLocString(id: .unexpectedError) + "\(httpStatusCode)"
      
      }
      
    }
  }
}
