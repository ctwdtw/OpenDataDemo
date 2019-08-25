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
  static let imageCache = NSCache<NSString, NSData>()
  func loadImage(url: URL, placeHolder: UIImage? = nil, completion: (() -> Void)? = nil) {
    
    image = placeHolder
    
    if let nsdata = UIImageView.imageCache.object(forKey: NSString(string: url.absoluteString)) {
      image = UIImage(data: nsdata as Data)
      completion?()
      return
    }
    
    let urlRq = URLRequest(url: url)
    
    image = nil
    startActivityIndicator()
    URLSession.shared.dataTask(with: urlRq, completionHandler: { (data, response, error) in
      if let data = data,
        let response = response as? HTTPURLResponse, response.statusCode < 300,
        let loadedIamge = UIImage(data: data) {
        DispatchQueue.main.async { [weak self] in
          UIImageView.imageCache.setObject(data as NSData, forKey: NSString(string: url.absoluteString))
          self?.image = loadedIamge
          self?.stopActivityIndicator()
        }
      } else {
        DispatchQueue.main.async { [weak self] in
          self?.image = placeHolder
          self?.stopActivityIndicator()
        }
      }
    }).resume()
  }
}

extension UIImageView {
  private static var _centerActivityIndicator = [String: UIActivityIndicatorView]()
  private var centerActivityIndicator: UIActivityIndicatorView {
    let address = String(format: "%p", unsafeBitCast(self, to: Int.self))
    if let spinner = UIImageView._centerActivityIndicator[address] {
      return spinner
      
    } else {
      
      let indicator = UIActivityIndicatorView(style: .gray)
      //layout
      indicator.translatesAutoresizingMaskIntoConstraints = false
      addSubview(indicator)
      self.addSubview(indicator)
      indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      indicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
      indicator.heightAnchor.constraint(equalTo: indicator.widthAnchor).isActive = true
      
      //store
      UIImageView._centerActivityIndicator[address] = indicator
      
      return indicator
    }
  }
  
  func startActivityIndicator() {
    bringSubviewToFront(centerActivityIndicator)
    centerActivityIndicator.startAnimating()
  }
  
  func stopActivityIndicator() {
    sendSubviewToBack(centerActivityIndicator)
    centerActivityIndicator.stopAnimating()
  }
  
  
}
