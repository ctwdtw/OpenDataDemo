//
//  StrechyViewController.swift
//  DDT_DEMO
//
//  Created by Paul Hung-Yi Lee on 2019/8/19.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import UIKit

class StrechyVＣ: UIViewController, UIScrollViewDelegate {
  @IBOutlet weak var strechyView: UIView!
  
  @IBOutlet weak var strechyHeight: NSLayoutConstraint!
  
  @IBOutlet weak var scrollViewContainer: UIView!
  
  var scrollableView: UIScrollView!
  
  var minStrechyHeight: CGFloat {
    let safeAreaTop = view.safeAreaInsets.top //right value accessable only after viewDidAppear()
    let systemNavHeight = navigationController?.navigationBar.frame.height ?? 0
    return safeAreaTop + systemNavHeight
  }

  var maxStrechyHeight: CGFloat {
    return minStrechyHeight * 4
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: R.nib.strechyVC.name, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.view = R.nib.strechyVC.firstView(owner: self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = true
    setupScrollableView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    performLayoutAdjustment()
  }
  
  /// tackle safe area problem
  private func performLayoutAdjustment() {
    strechyHeight.constant = maxStrechyHeight
  }
  
  /// override this method for using your own scrollable view, and render
  /// it on scrollViewContainer
  func setupScrollableView() {
    fatalError("must be override")
  }
  
  // MARK: - display logic
  func magneticEffect() {
    if strechyHeight.constant < maxStrechyHeight/2 {
      strechyHeight.constant = minStrechyHeight
      
    } else if strechyHeight.constant >= maxStrechyHeight/2 {
      strechyHeight.constant = maxStrechyHeight
      
    }
    
    UIView.animate(withDuration: 0.3) {
      self.view.layoutIfNeeded()
      
    }
    
  }
  
  // MARK: - scrollView Delegate
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let y = scrollView.contentOffset.y
    
    var newHeight = strechyHeight.constant - y
    
    if newHeight < minStrechyHeight {
      newHeight = minStrechyHeight
      
    } else if newHeight > maxStrechyHeight {
      newHeight = maxStrechyHeight
      
    } else {
      scrollView.contentOffset.y = 0
      
    }
    
    strechyHeight.constant = newHeight
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    magneticEffect()
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    magneticEffect()
  }
  
}
