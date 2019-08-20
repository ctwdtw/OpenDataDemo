//
//  OpenDataFeedTests.swift
//  OpenDataFeedTests
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import XCTest
@testable import OpenDataFeed

class OpenDataFeedTests: XCTestCase {
  var sut: PlantLoader!
  override func setUp() {
    sut = PlantLoader(limit: 10, offset: 0)
  }
  
  override func tearDown() {
    sut = nil
  }
  
  func test_load_loadPlant() {
    //given
    let exp = expectation(description: "api returns")
    var plants: [Plant]!
    
    //when
    sut.load { (result) in
      plants = result.value
      exp.fulfill()
    }
    
    //then
    wait(for: [exp], timeout: 10.0)
    XCTAssert(plants.isEmpty == false)
    
  }
  
  func test_load_loadMorePlants() {
    //given
    let exp = expectation(description: "api returns")
  
    var firstIdOfFirstLoad: Int!
    var firstIdOfSecondLoad: Int!
    //when
    sut.load { (result1) in
      firstIdOfFirstLoad = result1.value?.first?.id
      self.sut.load(completion: { (result2) in
        firstIdOfSecondLoad = result2.value?.first?.id
        exp.fulfill()
      })
    }
    
    //then
    wait(for: [exp], timeout: 10)
    //(offset, limit) = (0, 10)  -> _id (1, 10), row (0, 9)
    //(offset, limit) = (10, 10) -> _id (11, 20), row (10, 19)
    XCTAssertEqual(firstIdOfSecondLoad, firstIdOfFirstLoad + sut.limit)
    
  }
  
  func test_imageRequest_returnCorrectURLString() {
    let url = URL(string: "http://www.zoo.gov.tw/iTAP/04_Plant/Asteraceae/Farfugium/Farfugium_1.jpg")!
    let rq = PlantImageRequest(url: url)
    
    let urlRq = rq.makeURLRequest()
    
    let s1 = urlRq.url!.absoluteString
    let s2 = url.absoluteString
    
    XCTAssertEqual(s1, s2)
    
  }
  
  func test_loadImage_success_whenImagePathValide() {
    //given
    let url = URL(string: "http://www.zoo.gov.tw/iTAP/04_Plant/Asteraceae/Farfugium/Farfugium_1.jpg")!
    let exp = expectation(description: "api return")
    var d: Data!
    
    //when
    sut.loadImage(from: url) { (result) in
      d = result.value
      exp.fulfill()
    }
    
    wait(for: [exp], timeout: 10)
    
    //then
    XCTAssertNotNil(d)
  }
  
  func test_loadImage_failedWithError_whenImagePathBroken() {
    //given
    let url = URL(string: "http://www.zoo.gov.tw/iTAP/04_Plant/?Lamiaceae/Callicarpa/Callicarpa_1.jpg")!
    let exp = expectation(description: "api return")
    var e: Error!
    
    //when
    sut.loadImage(from: url) { (result) in
      e = result.error
      exp.fulfill()
    }
    
    wait(for: [exp], timeout: 10)
    
    //then
    XCTAssertNotNil(e)
  }
  
}
