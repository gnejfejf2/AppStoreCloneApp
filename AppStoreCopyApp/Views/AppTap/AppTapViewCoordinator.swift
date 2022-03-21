//
//  AppTapViewCoordinator.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit

class AppTapViewCoordinator: BaseCoordinator {
    
    
    
    override func start() {
        let viewModel = AppTapViewModel(builder: .init())
        let viewController = AppTapViewController.instantiate()
        viewController.viewModel = viewModel
        let vc = UINavigationController(rootViewController: viewController)
        self.navigationController = vc
        
    }
  
    
}
