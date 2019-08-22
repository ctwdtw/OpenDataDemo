//
//  ViewController.swift
//  OpenDataDemo
//
//  Created by Paul Lee on 2019/8/20.
//  Copyright © 2019 Paul Hung-Yi Lee. All rights reserved.
//

import UIKit

protocol ListPlantsDisplayable {
  func displayInsertPlantsSuccess(idxs: [Int])
  func displayInsertPlantsFailed(error: Error)
  func displayLoadingIndicator(isLoading: Bool)
}

class ListPlantsVC: StrechyVＣ, ListPlantsDisplayable {
  override var minStrechyHeight: CGFloat {
    return super.minStrechyHeight + AccountHeaderView.maskHeight
  }
  
  override var maxStrechyHeight: CGFloat {
    return (minStrechyHeight - AccountHeaderView.maskHeight) * 3 + AccountHeaderView.maskHeight
  }
  
  override var strechyView: UIView!{
    didSet{
      headerView = R.nib.accountHeaderView.firstView(owner: nil)
      headerView.fill(on: strechyView)
      
    }
  }
  
  var headerView: AccountHeaderView!
  
  var plantTableView: UITableView! {
    didSet {
      plantTableView.fill(on: scrollViewContainer)
      plantTableView.register(R.nib.plantCell)
      plantTableView.delegate = self
      plantTableView.dataSource = self
    }
  }
  
  private var cellHeights: [IndexPath: CGFloat] = [:]
  
  private var listPlantsViewModel: (ListPlantsDisplayLogicBindable & ListPlantsBusinessLogic)!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    listPlantsViewModel = ListPlantsViewModel(loader: PlantLoader(limit: 20, offset: 0))
  }
  
  override func setupScrollableView() {
    plantTableView = UITableView(frame: .zero)
    scrollableView = plantTableView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    bindDisplayLogic()
    listPlantsViewModel.load()
  }
  
  /// bind UI displaylogic of views with ports of related properties on viewModel
  func bindDisplayLogic() {
    listPlantsViewModel.onLoadingChange = displayLoadingIndicator(isLoading:)
    listPlantsViewModel.onInsertingPlantCellViewModels = displayInsertPlantsSuccess(idxs:)
    listPlantsViewModel.onFailedInsertingPlantCellViewModels = displayInsertPlantsFailed(error:)
  }
  
  //MARK: - UI display logics
  func displayInsertPlantsSuccess(idxs: [Int]) {
    let indexPaths = idxs.map { IndexPath(row: $0, section: 0) }
    plantTableView.insertRows(at: indexPaths, with: .none)
    
  }
  
  func displayInsertPlantsFailed(error: Error) {
    showSimpleAlert(error.localizedDescription, okTitle: "確認")
    print(error.localizedDescription)
  }
  
  func displayLoadingIndicator(isLoading: Bool) {
    if isLoading {
      plantTableView.startFooterSpinner()
      
    } else {
      plantTableView.stopFooterSpinner()
      
    }
  }
  
  func alphaValue(from height: CGFloat) -> (propValue: CGFloat, inverseValue: CGFloat) {
    let propValue = (height - minStrechyHeight)/(maxStrechyHeight - minStrechyHeight)
    let inverseValue = (height - maxStrechyHeight)/(minStrechyHeight - maxStrechyHeight)
    return (propValue, inverseValue)
  }
  
  //MARK: - Display helpers
  private func alphaProportional(to height: CGFloat) -> CGFloat {
    return (height - minStrechyHeight)/(maxStrechyHeight - minStrechyHeight)
  }
  
  private func alphaInversely(to height: CGFloat) -> CGFloat {
    return (height - maxStrechyHeight)/(minStrechyHeight - maxStrechyHeight)
  }
  
  override func magneticEffect() {
    super.magneticEffect()
    
    UIView.animate(withDuration: 0.3) {
      let alpha = self.alphaValue(from: self.strechyHeight.constant)
      self.headerView.setAlpha(alpha.propValue, alpha.inverseValue)
      
    }
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    super.scrollViewDidScroll(scrollView)
    
    //alpha
    let alpha = alphaValue(from: strechyHeight.constant)
    headerView.setAlpha(alpha.propValue, alpha.inverseValue)
    
    //loading
//    if let tableView = scrollView as? UITableView, tableView.isScrolledToEnd {
//      listPlantsViewModel.load()
//    }
    
  }
  
}

//MARK: - UITableVeiw DataSource
extension ListPlantsVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listPlantsViewModel.plantCellViewModels.count
  }
  
  func isScrollNearEnd(indexPath: IndexPath) -> Bool {
    return indexPath.row == listPlantsViewModel.plantCellViewModels.count - 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.plantCell, for: indexPath)!
    let viewModel = listPlantsViewModel.plantCellViewModels[indexPath.row]
    
    cell.bindDisplayLogic(viewModel)
    cell.display(viewModel)
    cell.plantCellViewModel = viewModel
    listPlantsViewModel.loadImage(for: viewModel)
    
    //loading
    if isScrollNearEnd(indexPath: indexPath) {
      listPlantsViewModel.load()
    }
    
    return cell
    
  }
}

//MARK: - UITableVeiw Delegate
extension ListPlantsVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cellHeights[indexPath] = cell.frame.size.height
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    if let height = cellHeights[indexPath] {
      return height
      
    } else {
      return 0
      
    }
  }
}
