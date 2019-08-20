//
//  PlantLoader.swift
//  OpenDataFeed
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
final class PlantLoader: OpenDataLoader {
  typealias DataObj = [Plant]
  
  // MARK:- dependency
  var client = APISession.shared
  
  // MARK:- state and initializer
  var limit: Int
  var offset: Int
  
  init(limit: Int, offset: Int) {
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
    client.send(rq) { (response) in
      
      if let e = response.result.error {
        completion(Result.failed(e))
        return
      }
      
      if let value = response.result.value {
        completion(Result.success(value))
        return
      }
      
      assertionFailure()
    
    }
    
  }
  
}
