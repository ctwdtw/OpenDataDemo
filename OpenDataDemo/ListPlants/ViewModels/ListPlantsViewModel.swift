//
//  ListPlantsViewModel.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation

protocol ListPlantsDisplayLogicBindable: class {
  var plantCellViewModels: [PlantCellViewModel] { get }
  var onInsertingPlantCellViewModels: (([Int]) -> Void)? { set get }
  var onFailedInsertingPlantCellViewModels: ((Error) -> Void)? { set get }
  var isLoading: Bool { get }
  var onLoadingChange: ((Bool) -> Void)? { set get }
}

protocol ListPlantsBusinessLogic {
  func load()
  func loadImage(for viewModel: PlantCellViewModel)
}

class ListPlantsViewModel: (ListPlantsDisplayLogicBindable & ListPlantsBusinessLogic) {
  
  //MARK: -display logic binding ports
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
    
    loader.load { [unowned self] (result) in
      defer {
        self.isLoading = false
      }
      
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
    guard let url = viewModel.imageURL else {
      viewModel.plantImageData = AssetExtractor.imageData(imageName: R.image.imagePlaceHolder.name)
      return
    }
    
    guard viewModel.isLoading == false else { return }
    
    viewModel.isLoading = true
    
    loader.loadImage(from: url) { (result) in
      defer {
        viewModel.isLoading = false
      }
      
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
