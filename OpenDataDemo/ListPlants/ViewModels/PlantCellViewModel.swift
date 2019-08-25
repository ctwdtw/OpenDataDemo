//
//  PlantCellViewModel.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import Foundation

protocol PlantPresentable {
  var id: String { get }
  var name: String { get }
  var location: String? { get }
  var feature: String? { get }
  var imageURL: URL? { get }
}

struct PlantCellViewModel {
  //MARK: - properties and initializer
  private var plant: Plant
  
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
  
  var imageURL: URL? {
    return plant.imageURL
  }
  
}

extension PlantCellViewModel {
  /// quck init and for the sake of generating test data
  init(id: Int, url: URL) {
    let plant = Plant(id: id, name: "plant\(id)", location: nil, feature: nil, imageURL: url)
    self.init(plant: plant)
  }
}
