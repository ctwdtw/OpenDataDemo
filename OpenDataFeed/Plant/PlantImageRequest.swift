//
//  PlantImageRequest.swift
//  OpenDataFeed
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
struct PlantImageRequest: OpenDataRequestable {
  typealias Obj = Data
  
  var path: String? {
    return nil
  }
  
  var httpMethod: HTTPMethod {
    return .get
  }
  
  var baseURL: URL {
    return url
  }
  
  let url: URL
  
  init(url: URL) {
    self.url = url
  }
  
}
