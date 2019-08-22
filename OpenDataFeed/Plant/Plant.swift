//
//  Plant.swift
//  OpenDataFeed
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation

struct Plant {
  let id: Int
  let name: String
  let location: String?
  let feature: String?
  let imageURL: URL?
}

extension Plant: Codable {
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case name = "F_Name_Ch"
    case location = "F_Location"
    case feature = "F_Feature"
    case imageURL = "F_Pic01_URL"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    self.location = try container.decodeIfPresent(String.self, forKey: .location)
    self.feature = try container.decodeIfPresent(String.self, forKey: .feature)
    
    if let urlString = try container.decodeIfPresent(String.self, forKey: .imageURL),
      let imageURL = URL(string: urlString) {
      self.imageURL = imageURL
      
    } else {
      self.imageURL = nil
      
    }
    
  }
}

extension Plant {
  /// quck init and for the sake of generating test data
  init(id: Int) {
    self.init(id: id, name: "plant\(id)", location: nil, feature: nil, imageURL: nil)
  }
}
