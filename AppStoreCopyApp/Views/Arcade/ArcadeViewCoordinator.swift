//
//  ArcadeViewCoordinator.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit

class ArcadeViewCoordinator: BaseCoordinator {
    
    
    
    override func start() {
        let viewModel = ArcadeViewModel(builder: .init())
        let viewController = ArcadeViewController.instantiate()
        viewController.viewModel = viewModel
        let vc = UINavigationController(rootViewController: viewController)
        self.navigationController = vc
        
    }
  
    
}
