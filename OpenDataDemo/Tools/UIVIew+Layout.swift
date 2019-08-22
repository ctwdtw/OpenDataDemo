//
//  UIVIew+Layout.swift
//  DDT_DEMO
//
//  Created by Paul Hung-Yi Lee on 2019/8/18.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func fill(on superView: UIView, top topPadding: CGFloat = 0, trailing trailingPadding: CGFloat = 0, bottom bottomPadding: CGFloat = 0, leading leadingPadding: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    superView.addSubview(self)
    topAnchor.constraint(equalTo: superView.topAnchor, constant: topPadding).isActive = true
    trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: trailingPadding).isActive = true
    bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: bottomPadding).isActive = true
    leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leadingPadding).isActive = true
  }
  
  func anchorTopFill(on superView: UIView, height: CGFloat, top topPadding: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    superView.addSubview(self)
    leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
    trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    topAnchor.constraint(equalTo: superView.topAnchor, constant: topPadding).isActive = true
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
}
