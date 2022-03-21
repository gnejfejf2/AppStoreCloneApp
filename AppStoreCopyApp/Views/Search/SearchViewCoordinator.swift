//
//  SearchViewCoordinator.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit
class SearchViewCoordinator: BaseCoordinator {
    
    
    
    override func start() {
        let viewModel = SearchViewModel(builder: .init())
        let viewController = SearchViewController.instantiate()
        viewController.viewModel = viewModel
        let vc = UINavigationController(rootViewController: viewController)
       
        self.navigationController = vc
        
    }
  
    
}
