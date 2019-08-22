//
//  OpenDataLoader.swift
//  OpenDataFeed
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
import Foundation
protocol OpenDataLoader {
  var limit: Int { set get }
  var offset: Int { set get }
  
  associatedtype DataObj
  func load(completion: @escaping (Result<DataObj, Error>) -> Void)
  func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
