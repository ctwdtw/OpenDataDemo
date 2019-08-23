//
//  PlantLoader.swift
//  OpenDataFeed
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
class PlantLoader: OpenDataLoader {
  typealias DataObj = [Plant]
  
  // MARK:- dependency
  var client = APISession.shared
  private let cache = NSCache<NSString, NSData>()
  
  // MARK:- state and initializer
  var limit: Int
  var offset: Int
  
  init(limit: Int = 20, offset: Int = 0) {
    self.limit = limit
    self.offset = offset
  }
  
  // MARK:- implementation of business logic
  func load(completion: @escaping (Result<[Plant], Error>) -> Void) {
    let rq = PlantRequest(limit: limit, offset: offset)
    client.send(rq) { [weak self] (response) in
      guard let strongSelf = self else { return }
      
      if let e = response.result.error {
        completion(Result.failed(e))
        return
      }
      
      if let plants = response.result.value?.results {
        strongSelf.offset = strongSelf.offset + plants.count
        completion(Result.success(plants))
        return
      }
      
      assertionFailure()
      
    }
  }
  
  func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
    let rq = PlantImageRequest(url: url)
    
    if let nsdata = cache.object(forKey: NSString(string: url.absoluteString)) {
      let imageData = Data(referencing: nsdata)
      completion(Result.success(imageData))
      return
    }
    
    client.send(rq) { [weak self] (response) in
      
      if let e = response.result.error {
        completion(Result.failed(e))
        return
      }
      
      if let value = response.result.value {
        self?.cache.setObject(NSData(data: value), forKey: NSString(string: url.absoluteString))
        completion(Result.success(value))
        return
      }
      
      assertionFailure()
    
    }
    
  }
  
}
