//
//  PlantCell.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import UIKit

class PlantCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel! {
    didSet {
      nameLabel.numberOfLines = 0
      nameLabel.textColor = .black
      nameLabel.font = UIFont.systemFont(ofSize: 17)
      nameLabel.textAlignment = .left
    }
  }
  
  @IBOutlet weak var locationLabel: UILabel! {
    didSet {
      locationLabel.numberOfLines = 0
      locationLabel.textColor = .darkGray
      locationLabel.font = UIFont.systemFont(ofSize: 15)
      locationLabel.textAlignment = .justified
    }
  }
  
  @IBOutlet weak var featureLabel: UILabel! {
    didSet {
      featureLabel.numberOfLines = 0
      featureLabel.textColor = .gray
      featureLabel.font = UIFont.systemFont(ofSize: 17)
      featureLabel.textAlignment = .justified
    }
  }
  
  
  @IBOutlet weak var imageViewContainer: UIView! {
    didSet {
      let imageView = UIImageView(frame: .zero)
      imageView.fill(on: imageViewContainer)
      plantImageView = imageView
    }
  }
  
  var plantImageView: UIImageView?
  
  func display(_ viewModel: PlantPresentable) {
    nameLabel.text = viewModel.name
    locationLabel.text = viewModel.location
    featureLabel.text = viewModel.feature
    
    if let url = viewModel.imageURL {
      plantImageView?.loadImage(url: url, placeHolder: R.image.imagePlaceHolder()!)
    
    } else {
      plantImageView?.image = R.image.imagePlaceHolder()!
    
    }
  
    setNeedsLayout()
  }
  
  func prepareNewImageView() {
    plantImageView?.removeFromSuperview()
    plantImageView = nil
    plantImageView = UIImageView(frame: .zero)
    plantImageView?.fill(on: imageViewContainer)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    prepareNewImageView()
  }
  
}
