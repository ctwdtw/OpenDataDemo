//
//  PlantValue.swift
//  OpenDataFeed
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
struct PlantValue: Decodable {
  let limit: Int
  let offset: Int
  let totalPlants: Int
  let results: [Plant]
  
  enum CodingKeys: String, CodingKey {
    case result = "result"
    case limit = "limit"
    case offset = "offset"
    case totalPlants = "count"
    case results = "results"
    
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let result = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .result)
    self.limit = try result.decode(Int.self, forKey: .limit)
    self.offset = try result.decode(Int.self, forKey: .offset)
    self.totalPlants = try result.decode(Int.self, forKey: .totalPlants)
    self.results = try result.decode([Plant].self, forKey: .results)
  }
  
}
