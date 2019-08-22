//
//  ViewController.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import UIKit

protocol ListPlantsDisplayable {
  func displayLoadPlantsSuccess(idxs: [Int])
  func displayLoadPlantsFailed(error: Error)
  func displayLoadingIndicator(isLoading: Bool)
}

class ListPlantsVC: StrechyVＣ, ListPlantsDisplayable {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
  }
  
  override func setupScrollableView() {
    let textView = UITextView(frame: .zero)
    textView.fill(on: scrollViewContainer)
    textView.font = UIFont.systemFont(ofSize: 30)
    textView.text = "Lorem ipsum dolor sit amet, alii nominavi elaboraret an mea, sint liber iuvaret per ne, mea ei facilis civibus. Tollit perpetua id has, eam doctus cetero electram ex. His torquatos abhorreant vituperatoribus ad. Quas oblique accusamus ei his, has lorem sanctus eu. Nam malorum constituto persequeris te, nam no gubergren voluptaria, clita ornatus cum no. Modus scripserit appellantur ea sea, in per reque luptatum.Lorem ipsum dolor sit amet, alii nominavi elaboraret an mea, sint liber iuvaret per ne, mea ei facilis civibus. Tollit perpetua id has, eam doctus cetero electram ex. His torquatos abhorreant vituperatoribus ad. Quas oblique accusamus ei his, has lorem sanctus eu. Nam malorum constituto persequeris te, nam no gubergren voluptaria, clita ornatus cum no. Modus scripserit appellantur ea sea, in per reque luptatum.Lorem ipsum dolor sit amet, alii nominavi elaboraret an mea, sint liber iuvaret per ne, mea ei facilis civibus. Tollit perpetua id has, eam doctus cetero electram ex. His torquatos abhorreant vituperatoribus ad. Quas oblique accusamus ei his, has lorem sanctus eu. Nam malorum constituto persequeris te, nam no gubergren voluptaria, clita ornatus cum no. Modus scripserit appellantur ea sea, in per reque luptatum.Lorem ipsum dolor sit amet, alii nominavi elaboraret an mea, sint liber iuvaret per ne, mea ei facilis civibus. Tollit perpetua id has, eam doctus cetero electram ex. His torquatos abhorreant vituperatoribus ad. Quas oblique accusamus ei his, has lorem sanctus eu. Nam malorum constituto persequeris te, nam no gubergren voluptaria, clita ornatus cum no. Modus scripserit appellantur ea sea, in per reque luptatum.Lorem ipsum dolor sit amet, alii nominavi elaboraret an mea, sint liber iuvaret per ne, mea ei facilis civibus. Tollit perpetua id has, eam doctus cetero electram ex. His torquatos abhorreant vituperatoribus ad. Quas oblique accusamus ei his, has lorem sanctus eu. Nam malorum constituto persequeris te, nam no gubergren voluptaria, clita ornatus cum no. Modus scripserit appellantur ea sea, in per reque luptatum.Lorem ipsum dolor sit amet, alii nominavi elaboraret an mea, sint liber iuvaret per ne, mea ei facilis civibus. Tollit perpetua id has, eam doctus cetero electram ex. His torquatos abhorreant vituperatoribus ad. Quas oblique accusamus ei his, has lorem sanctus eu. Nam malorum constituto persequeris te, nam no gubergren voluptaria, clita ornatus cum no. Modus scripserit appellantur ea sea, in per reque luptatum.Lorem ipsum dolor sit amet, alii nominavi elaboraret an mea, sint liber iuvaret per ne, mea ei facilis civibus. Tollit perpetua id has, eam doctus cetero electram ex. His torquatos abhorreant vituperatoribus ad. Quas oblique accusamus ei his, has lorem sanctus eu. Nam malorum constituto persequeris te, nam no gubergren voluptaria, clita ornatus cum no. Modus scripserit appellantur ea sea, in per reque luptatum."
    textView.delegate = self
    
  }
  
  //MARK: - display lgoic
  func displayLoadPlantsSuccess(idxs: [Int]) {
    
  }
  
  func displayLoadPlantsFailed(error: Error) {
    
  }
  
  func displayLoadingIndicator(isLoading: Bool) {
    
  }


}

extension ListPlantsVC: UITextViewDelegate {
  
}
