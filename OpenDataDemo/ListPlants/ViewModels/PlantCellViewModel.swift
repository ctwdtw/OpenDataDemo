//
//  PlantCellViewModel.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation

protocol PlantPresentable: class {
  var id: String { get }
  var name: String { get }
  var location: String? { get }
  var feature: String? { get }
  var plantImageData: Data? { get set }
}

protocol PlantDisplayLogicBindable: class {
  var plantImageData: Data? { get set }
  var onImageDataLoaded: ((Data) -> Void)? { get set }
  var isLoading: Bool { get set }
  var onLoadingChange: ((Bool) -> Void)? { get set }
}

class PlantCellViewModel: PlantDisplayLogicBindable {
  
  //MARK:- display logic binding ports
  var onImageDataLoaded: ((Data) -> Void)?
  
  var onLoadingChange: ((Bool) -> Void)?
  
  //MARK: - properties and initializer
  private var plant: Plant
  
  var plantImageData: Data? {
    didSet {
      if let data = plantImageData {
        onImageDataLoaded?(data)
      }
    }
  }
  
  var isLoading: Bool = false {
    didSet {
      onLoadingChange?(isLoading)
    }
  }
  
  var imageURL: URL? {
    return plant.imageURL
  }
  
  init(plant: Plant) {
    self.plant = plant
  }
  
}

//MARK:- presentation logic
extension PlantCellViewModel: PlantPresentable {

  var id: String {
    return "\(plant.id)"
  }
  
  var name: String {
    return plant.name
  }
  
  var location: String? {
    return plant.location
  }
  
  var feature: String? {
    return plant.feature
  }
  
}

extension PlantCellViewModel {
  /// quck init and for the sake of generating test data
  convenience init(id: Int, url: URL) {
    let plant = Plant(id: id, name: "plant\(id)", location: nil, feature: nil, imageURL: url)
    self.init(plant: plant)
  }
}
