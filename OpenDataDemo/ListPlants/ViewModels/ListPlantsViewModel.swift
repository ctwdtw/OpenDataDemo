//
//  ListPlantsViewModel.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation

protocol ListPlantsDisplayLogicBindable {
  var onInsertingPlantCellViewModels: (([Int]) -> Void)? { set get }
  var onFailedInsertingPlantCellViewModels: ((Error) -> Void)? { set get }
  var onLoadingChange: ((Bool) -> Void)? { set get }
}

class ListPlantsViewModel: ListPlantsDisplayLogicBindable {
  
  //MARK: -display logic binding port
  var onInsertingPlantCellViewModels: (([Int]) -> Void)?
  
  var onFailedInsertingPlantCellViewModels: ((Error) -> Void)?
  
  var onLoadingChange: ((Bool) -> Void)?
  
  //MARK: - properties and initializer
  private(set) var loader: PlantLoader
  
  private(set) var plantCellViewModels: [PlantCellViewModel] {
    didSet {
      let idxs = Array(oldValue.count..<loader.offset)
      onInsertingPlantCellViewModels?(idxs)
    }
  }
  
  private(set) var isLoading: Bool {
    didSet {
      onLoadingChange?(isLoading)
    }
  }
  
  init(loader: PlantLoader, isLoading: Bool = false, viewModels: [PlantCellViewModel] = []) {
    self.loader = loader
    self.isLoading = isLoading
    self.plantCellViewModels = viewModels
  }
  
  private func presentPlants(_ plants: [Plant]) -> [PlantCellViewModel] {
    return plants.map { PlantCellViewModel(plant: $0) }
  }
  
  func load() {
    guard isLoading == false else { return }
    
    isLoading = true
    
    defer {
      self.isLoading = false
    }
    
    loader.load { [unowned self] (result) in
      
      if let e = result.error {
        self.onFailedInsertingPlantCellViewModels?(e)
        return
      }
      
      if let plants = result.value {
        let cellViewModels = self.presentPlants(plants)
        self.plantCellViewModels.append(contentsOf: cellViewModels)
        return
      }
      
      assertionFailure()
      
    }
  
  }
  
  func loadImage(for viewModel: PlantCellViewModel) {
    guard viewModel.isLoading == false else { return }
    
    viewModel.isLoading = true
    
    defer {
      viewModel.isLoading = false
    }
    
    guard let url = viewModel.imageURL else {
      viewModel.plantImageData = AssetExtractor.imageData(imageName: R.image.imagePlaceHolder.name)
      return
    }
    
    loader.loadImage(from: url) { (result) in
      
      if let _ = result.error {
        viewModel.plantImageData = AssetExtractor.imageData(imageName: R.image.imagePlaceHolder.name)
        return
      }
      
      if let data = result.value {
        viewModel.plantImageData = data
        return
      }
      
      assertionFailure()
      
    }
  
  }
  
}
