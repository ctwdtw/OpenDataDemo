//
//  AssetExtractor.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/21.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
import UIKit
class AssetExtractor {
  static func imageData(imageName: String) -> Data {
    if let image = UIImage(named: imageName), let data = image.pngData() {
      return data
    }
    
    fatalError()
    
  }
}
