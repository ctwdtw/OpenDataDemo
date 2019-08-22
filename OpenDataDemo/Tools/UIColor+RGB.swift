//
//  UIColor+RGB.swift
//  DDT_DEMO
//
//  Created by Paul Hung-Yi Lee on 2019/8/19.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  convenience init(R: Int, G: Int, B: Int, alpha: CGFloat) {
    self.init(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha: alpha)
  }
}
