//
//  PlantRequest.swift
//  OpenDataFeed
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
struct PlantRequest: OpenDataRequestable {
  
  typealias Obj = PlantValue
  
  var path: String? {
    return "/apiAccess"
  }
  
  var httpMethod: HTTPMethod {
    return .get
  }
  
  let limit: Int
  
  let offset: Int
  
  init(limit: Int = 15, offset: Int) {
    self.limit = limit
    self.offset = offset
  }
  
  var queryParameters: [String : Any] {
    return ["scope": "resourceAquire",
            "rid": "f18de02f-b6c9-47c0-8cda-50efad621c14",
            "limit": "\(limit)",
      "offset": "\(offset)"]
  }
  
}
