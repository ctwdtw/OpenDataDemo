//
//  APISession.swift
//  API Exercise
//
//  Created by Paul Lee on 2018/9/10.
//  Copyright © 2018 Paul Lee. All rights reserved.
//

/**
 用來向後台送 http request 的 singleton 物件, 將 url session 做了一個簡單的封裝。
*/

import Foundation

///用來向後台送 http request 的 singleton 物件
public class APISession {

  /// 底層用來送 request 的 session
  private var session: URLSession
  
  ///singleton
  static let shared = APISession()
  
  ///將初始化 session 的建構子私有化, 確保只有一個 instance
  private init() {
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    session = URLSession.init(configuration: config)
  }
  
  /// 向後台送出 http request 的 function
  ///
  /// - Parameters:
  ///   - request: Http Request
  ///   - completion: request 成功後, 被執行的閉包
  public func send<T: Requestable>(_ request: T,
                                   completion: @escaping (Response<T>)-> Void) {
    let urlRequest = request.makeURLRequest()
    let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
      guard error == nil else {
        let rs = Response(request: request, data: data, response: urlResponse as? HTTPURLResponse, result: Result.failed(error!))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
      }
      
      guard let httpResponse = urlResponse as? HTTPURLResponse else {
        
        let rs = Response(request: request,
                          data: nil,
                          response: nil,
                          result: Result.failed(APIClientError.noResponse))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
        
      }
      
      guard let responseData = data else {
        let rs = Response(request: request, data: nil, response: httpResponse, result: Result.failed(APIClientError.noData))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
        
      }
      
      //FIXME: - this is dirty, only a qick fix for allowing image data, need future refactor
      if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String,
        contentType == "image/jpeg" || contentType == "image/png" || contentType == "image/*",
        let obj = responseData as? T.Obj {
  
        let rs = Response(request: request, data: responseData, response: httpResponse, result: Result.success(obj))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
      }
      
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      
      if let obj = try? decoder.decode(T.Obj.self, from: responseData) {
        let rs = Response(request: request, data: responseData, response: httpResponse, result: Result.success(obj))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
        
      } else if let json = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
        // decode error
        let error = APIClientError.unexpectedJSON(httpStatusCode: httpResponse.statusCode, json: json)
        let rs = Response(request: request, data: responseData, response: httpResponse, result: Result.failed(error))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
        
      } else {
        //unexpect error could be server return html file instead of json
        let dataString = String(data: responseData, encoding: String.Encoding.utf8)
        let error = APIClientError.unexpectedError(httpStatusCode: httpResponse.statusCode, dataString: dataString)
        let rs = Response(request: request, data: responseData, response: httpResponse, result: Result.failed(error))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
      }
      
    }
    
    task.resume()
  }
  
  /// 向後台送出 upload data 的 http request
  ///
  /// - Parameters:
  ///   - request: 包含 uplodad data 的 request
  ///   - completion: upload 成功後被執行的閉包
  public func send<T: Requestable & UploadRequestable>(_ request: T, completion: @escaping (Response<T>)->Void) {
    let urlRequest = request.makeURLRequest()
    let uplaodData = request.uploadData
    let uploadTask = session.uploadTask(with: urlRequest, from: uplaodData) { data, urlResponse, error in
      guard error == nil else {
        let rs = Response(request: request, data: data, response: urlResponse as? HTTPURLResponse, result: Result.failed(error!))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
      }
      
      guard let httpResponse = urlResponse as? HTTPURLResponse else {
        
        let rs = Response(request: request,
                          data: nil,
                          response: nil,
                          result: Result.failed(APIClientError.noResponse))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
        
      }
      
      guard let responseData = data else {
        let rs = Response(request: request, data: nil, response: httpResponse, result: Result.failed(APIClientError.noData))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
        
      }
      
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      
      if let obj = try? decoder.decode(T.Obj.self, from: responseData) {
        let rs = Response(request: request, data: responseData, response: httpResponse, result: Result.success(obj))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
        
      } else if let json = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
        // decode error
        let error = APIClientError.unexpectedJSON(httpStatusCode: httpResponse.statusCode, json: json)
        let rs = Response(request: request, data: responseData, response: httpResponse, result: Result.failed(error))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
        
      } else {
        //unexpect error could be server return html file instead of json
        let dataString = String(data: responseData, encoding: String.Encoding.utf8)
        let error = APIClientError.unexpectedError(httpStatusCode: httpResponse.statusCode, dataString: dataString)
        let rs = Response(request: request, data: responseData, response: httpResponse, result: Result.failed(error))
        DispatchQueue.main.async {
          completion(rs)
        }
        
        return
      }
      
      
    }
    
    uploadTask.resume()
    
  }
  
}
