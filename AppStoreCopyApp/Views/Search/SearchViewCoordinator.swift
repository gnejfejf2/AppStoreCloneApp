//
//  SearchViewCoordinator.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit
class SearchViewCoordinator: BaseCoordinator {
    
    
    
    override func start() {
        let viewModel = SearchViewModel(builder: .init(
            cordinator: self
        ))
        let viewController = SearchViewController.instantiate()
        viewController.viewModel = viewModel
        let vc = UINavigationController(rootViewController: viewController)
        navigationController = vc
        
    }
  
    func openDetailView(appData : AppModel){
        let coordinator = AppDetailViewCoordinator(navigationController: navigationController)
        coordinator.appData = appData
        coordinator.start()
        
    }
    
}
