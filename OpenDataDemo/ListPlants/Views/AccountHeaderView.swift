//
//  ExpHeader.swift
//  DDT_DEMO
//
//  Created by Paul Hung-Yi Lee on 2019/8/19.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation
import UIKit

class AccountHeaderView: UIView {
  @IBOutlet weak var bankLabelCenterDisplacement: NSLayoutConstraint! // NavHeight/2 = 44/2
  
  @IBOutlet weak var depositSmallLabelCenterDisplacement: NSLayoutConstraint! // NavHeight/2 = 44/2

  @IBOutlet weak var bankNameLabel: UILabel!
  
  @IBOutlet weak var accountSegmentControl: UISegmentedControl!
  
  @IBOutlet weak var depositLabel: UILabel!
  
  @IBOutlet weak var depositSmallLabel: UILabel!
  
  static let maskHeight: CGFloat = 22.0 //44.0
  
  @IBOutlet weak var maskHeight: NSLayoutConstraint! {
    didSet {
      maskHeight.constant = AccountHeaderView.maskHeight
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    //
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = [UIColor.darkGreen.cgColor, UIColor.lightGreenLevel1.cgColor]
    layer.insertSublayer(gradient, at: 0)
    
    //
    depositSmallLabel.alpha = 0
    depositSmallLabel.textColor = .white
    
    //
    bankNameLabel.textColor = .white
    accountSegmentControl.tintColor = .white
    depositLabel.textColor = .white
  }
  
}

protocol AlphaChangealbe {
  func setAlpha(_ propValue: CGFloat, _ inverseValue: CGFloat)
}

extension AccountHeaderView: AlphaChangealbe {
  func setAlpha(_ propValue: CGFloat, _ inverseValue: CGFloat) {
    //
    bankNameLabel.alpha = propValue
    accountSegmentControl.alpha = propValue
    depositLabel.alpha = propValue
    
    //
    depositSmallLabel.alpha = inverseValue
    
  }

}
