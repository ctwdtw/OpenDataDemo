//
//  PlantCell.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import UIKit

protocol PlantsDisplayable {
  func displayLoadingIndicator(isLoading: Bool)
  func displayImageData(_ data: Data)
}

class PlantCell: UITableViewCell, PlantsDisplayable {
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
  
  @IBOutlet weak var plantImageView: UIImageView!
  
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView! {
    didSet {
      loadingIndicator.hidesWhenStopped = true
    }
  }
  
  var plantCellViewModel: (PlantPresentable & PlantDisplayLogicBindable)?
  
  func display(_ viewModel: PlantPresentable) {
    nameLabel.text = viewModel.name
    locationLabel.text = viewModel.location
    featureLabel.text = viewModel.feature
    setNeedsLayout()
  }
  
  func bindDisplayLogic(_ viewModel: PlantDisplayLogicBindable) {
    viewModel.onLoadingChange = displayLoadingIndicator(isLoading:)
    viewModel.onImageDataLoaded = displayImageData(_:)
  }
  
  //MARK: - dispaly logic
  func displayLoadingIndicator(isLoading: Bool) {
    if isLoading {
      loadingIndicator.startAnimating()
      
    } else {
      loadingIndicator.stopAnimating()
      
    }
  }
  
  func displayImageData(_ data: Data) {
    plantImageView.image = UIImage(data: data)
    plantCellViewModel?.isLoading = false
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    plantCellViewModel?.onImageDataLoaded = nil
    plantCellViewModel?.onLoadingChange = nil
    plantImageView.image = nil
  }
  
}
