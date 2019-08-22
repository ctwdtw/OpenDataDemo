//
//  OpenDataDemoTests.swift
//  OpenDataDemoTests
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import XCTest
@testable import OpenDataDemo

class OpenDataDemoTests: XCTestCase {
  var sut: ListPlantsViewModel!
  
  //MARK: - test `load()`
  class SpyLoader: PlantLoader {
    var isCalledToLoad = false
    override func load(completion: @escaping (Result<[Plant], Error>) -> Void) {
      isCalledToLoad = true
      completion(Result.success([]))
    }
    
    var isCalledToLoadImage = false
    override func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
      isCalledToLoadImage = true
      completion(Result.success(Data()))
    }
    
  }
  
  func test_load_callLoaderToLoad() {
    //given
    let spyLoader = SpyLoader()
    sut = ListPlantsViewModel(loader: spyLoader)
    
    //when
    sut.load()
    
    //then
    XCTAssertEqual(spyLoader.isCalledToLoad, true)
  }
  
  class StubLoader: PlantLoader {
    override func load(completion: @escaping (Result<[Plant], Error>) -> Void) {
      
      let plant0 = Plant(id: 0)
      
      let plant1 = Plant(id: 1)
      
      let plant2 = Plant(id: 2)
      
      let plants = [plant0, plant1, plant2]
      
      completion(Result.success(plants))
      
    }
    
    override func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
      completion(Result.success(Data()))
    }
    
  }
  
  //FIXME:// 這樣算是測試「行為」還是「實作」？是好的測試嗎？
  func test_load_insertPlantCellViewModels() {
    //given
    let stubLoader = StubLoader()
    sut = ListPlantsViewModel(loader: stubLoader)
    let countBeforeLoad = sut.plantCellViewModels.count
    
    //when
    sut.load()
    
    //then
    let countAfterLoad = sut.plantCellViewModels.count
    XCTAssertEqual(countAfterLoad, countBeforeLoad + 3)
  }
  
  class FakeLoader: PlantLoader {
    let plants = {
      return (0..<100).map{Plant(id: $0)}
    }()
    
    override func load(completion: @escaping (Result<[Plant], Error>) -> Void) {
      let returnPlants = Array(plants[offset..<offset+limit])
      
      offset = offset + returnPlants.count
      completion(Result.success(returnPlants))
    }
    
    override func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
      completion(Result.success(Data()))
    }
    
  }
  
  func test_fakeLoader() {
    //given
    let loader = FakeLoader(limit: 20, offset: 0)
    
    //when
    loader.load { (firstResult) in
      loader.load(completion: { (secondResult) in
        //then
        let firstLoadPlants = firstResult.value!
        let secondLoadPlants = secondResult.value!
        XCTAssertEqual(firstLoadPlants.first?.id, 0)
        XCTAssertEqual(firstLoadPlants.last?.id, 19)
        
        XCTAssertEqual(secondLoadPlants.first?.id, 20)
        XCTAssertEqual(secondLoadPlants.last?.id, 39)
      })
    }
  }
  
  func test_load_call_loadPlantsSuccessDisplayLogic_whenSuccess() {
    //given
    let stubLoader = StubLoader()
    sut = ListPlantsViewModel(loader: stubLoader)
    var isCalled = false
    sut.onInsertingPlantCellViewModels = { idxs in
      isCalled = true
    }
    
    //when
    sut.load()
    
    //then
    XCTAssertTrue(isCalled)
  }
  
  func test_load_passCorrectIdx_whenCallLoadPlantsSuccessDisplayLogic() {
    //given
    let currentCount = 5
    let limit = 10
    let offset = currentCount
    
    let viewModels = (0..<currentCount).map {Plant(id: $0)}.map { PlantCellViewModel(plant: $0) } //0 - 4
    let fakerLoader = FakeLoader(limit: limit, offset: offset) //5 - 14
    
    let sut = ListPlantsViewModel(loader: fakerLoader, viewModels: viewModels)
    var insertIdxs: [Int] = []
    var isCalled = false
    sut.onInsertingPlantCellViewModels = { idxs in
      isCalled = true
      insertIdxs = idxs
    }
    
    //when
    sut.load()
    
    //then
    XCTAssertTrue(isCalled)
    XCTAssertEqual(insertIdxs, Array(offset..<sut.plantCellViewModels.count))
    
  }
  
  class StubFailedLoader: PlantLoader {
    override func load(completion: @escaping (Result<[Plant], Error>) -> Void) {
      let e = APIClientError.noData
      completion(Result.failed(e))
    }
  }
  
  func test_load_call_loadPlantsFailedDisplayLogic_whenLoadFailed() {
    //given
    let stubLoader = StubFailedLoader()
    sut = ListPlantsViewModel(loader: stubLoader)
    var isCalled = false
    sut.onFailedInsertingPlantCellViewModels = { error in
      isCalled = true
    }
    //when
    sut.load()
    
    //then
    XCTAssertTrue(isCalled)
    
  }
  
  func test_load_doesNotCall_loader_WhenIsLoading() {
    //given
    let spyLoader = SpyLoader()
    let sut = ListPlantsViewModel(loader: spyLoader, isLoading: true)
    
    //when
    sut.load()
    
    //then
    XCTAssert(spyLoader.isCalledToLoad == false)
    
  }
  
  class DummyLoader: PlantLoader {}
  
  func test_load_trigger_loadingIndicatorDisplayLogic() {
    //given
    let dummyLoader = DummyLoader()
    
    let sut = ListPlantsViewModel(loader: dummyLoader)
    var isCalled = false
    sut.onLoadingChange = { isLoading in
      isCalled = true
    }
    
    //when
    sut.load()
    
    //then
    XCTAssertTrue(isCalled)
    
  }
  
  func test_load_giveBackCurrectLoadingState_WhenFinishLoad() {
    //given
    let spyLoader = SpyLoader()
    let sut = ListPlantsViewModel(loader: spyLoader)
    
    //when
    sut.load()
    
    //then
    XCTAssert(spyLoader.isCalledToLoad)
    XCTAssert(sut.isLoading == false)
    
  }
  
  //MARK: - test loadImage(for viewModel:)
  func test_loadImage_givesImageDataToCellViewModel() {
    //given
    let spyLoader = SpyLoader()
    let sut = ListPlantsViewModel(loader: spyLoader)
    let vm = PlantCellViewModel(plant: Plant(id: 0))
    
    //when
    sut.loadImage(for: vm)
    
    
    XCTAssertNotNil(vm.plantImageData)
    
  }
  
  func test_loadImage_callLoaderLoadImage() {
    //given
    let spyLoader = SpyLoader()
    let sut = ListPlantsViewModel(loader: spyLoader)
    let url = URL(string: "https://bit.ly/2HeN7yw")!
    let viewModel = PlantCellViewModel(id: 0, url: url)
    
    //when
    sut.loadImage(for: viewModel)
    
    //then
    XCTAssert(spyLoader.isCalledToLoadImage)
    
  }
  
  func test_loadImage_triggerCellDisplayLogicBindedOnCellViewModel() {
    //given
    let loader = StubLoader()
    let sut = ListPlantsViewModel(loader: loader)
    let url = URL(string: "https://bit.ly/2HeN7yw")!
    let viewModel = PlantCellViewModel(id: 0, url: url)
    
    var onImageDataLoadedCall = false
    viewModel.onImageDataLoaded = { data in
      onImageDataLoadedCall = true
    }
    
    var onLoadingChangeCalled = false
    viewModel.onLoadingChange = { isLoading in
      onLoadingChangeCalled = true
    }
    
    //when
    sut.loadImage(for: viewModel)
    
    //then
    XCTAssert(onImageDataLoadedCall == true)
    XCTAssert(onLoadingChangeCalled == true)
    
  }
  
  func test_loadImage_doesNotCallLoader_whenViewModelIsLoading() {
    //given
    let loader = SpyLoader()
    let sut = ListPlantsViewModel(loader: loader)
    let url = URL(string: "https://bit.ly/2HeN7yw")!
    let viewModel = PlantCellViewModel(id: 0, url: url)
    viewModel.isLoading = true
    
    //when
    sut.loadImage(for: viewModel)
    
    //then
    XCTAssertFalse(loader.isCalledToLoadImage)
    
  }
  
  func test_loadImage_giveCorrectCellViewModelLoadingState_whenFinishLoad() {
    //given
    let loader = SpyLoader()
    let sut = ListPlantsViewModel(loader: loader)
    let url = URL(string: "https://bit.ly/2HeN7yw")!
    let viewModel = PlantCellViewModel(id: 0, url: url)
    
    //when
    sut.loadImage(for: viewModel)
    
    //then
    XCTAssertTrue(loader.isCalledToLoadImage)
    XCTAssertFalse(viewModel.isLoading)
  }
  
}

