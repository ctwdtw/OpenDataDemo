//
//  UITableView+Spinner.swift
//  HealthToAllFlesh
//
//  Created by Paul Lee on 2018/8/14.
//  Copyright © 2018 Paul Lee. All rights reserved.
//

import Foundation
import UIKit
//import NVActivityIndicatorView

extension UITableView {
  var isScrolledToEnd: Bool {
    let offsetY = contentOffset.y
    let contentHeight = contentSize.height
    return offsetY > contentHeight + 30 - frame.height
  }
  
  private var footerSpinner: UIView {
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    indicator.hidesWhenStopped = false
    
    //layout
    let spinnerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
    spinnerView.backgroundColor = .white
    spinnerView.addSubview(indicator)
    
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.leadingAnchor.constraint(equalTo: spinnerView.leadingAnchor).isActive = true
    indicator.trailingAnchor.constraint(equalTo: spinnerView.trailingAnchor).isActive = true
    indicator.topAnchor.constraint(equalTo: spinnerView.topAnchor, constant: 8).isActive = true
    
    spinnerView.bottomAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 8).isActive = true
    indicator.startAnimating()
    
    return spinnerView
    
  }
  
  //center Spinner
  func startFooterSpinner() {
    guard tableFooterView == nil else {
      return
    }
    tableFooterView = footerSpinner
  }
  
  func stopFooterSpinner() {
    tableFooterView = nil
  }
  
}
