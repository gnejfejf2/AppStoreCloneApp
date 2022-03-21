//
//  GameViewCoordinator.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit

class GameViewCoordinator: BaseCoordinator {
    
    
    
    override func start() {
        let viewModel = GameViewModel(builder: .init())
        let viewController = GameViewController.instantiate()
        viewController.viewModel = viewModel
        let vc = UINavigationController(rootViewController: viewController)
        self.navigationController = vc
        
    }
  
    
}
