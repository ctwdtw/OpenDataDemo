//
//  UIImage+Loading.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/23.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
  static let imageCache = URLCache()
  func loadImage(url: URL, placeHolder: UIImage? = nil, completion: (() -> Void)? = nil) {
    let urlRq = URLRequest(url: url)
    
    if let data = UIImageView.imageCache.cachedResponse(for: urlRq)?.data, let retrivedImage = UIImage(data: data) {
      image = retrivedImage
      completion?()
      return
    }
    
    URLSession.shared.dataTask(with: urlRq, completionHandler: { (data, response, error) in
      defer {
        DispatchQueue.main.async {
          completion?()
        }
      }
      
      if let data = data,
        let response = response as? HTTPURLResponse, response.statusCode < 300,
        let loadedIamge = UIImage(data: data) {
        
        let cachedData = CachedURLResponse(response: response, data: data)
        UIImageView.imageCache.storeCachedResponse(cachedData, for: urlRq)
        DispatchQueue.main.async { [weak self] in
          self?.image = loadedIamge
        }
        
      }
    }).resume()
    
  }
}
