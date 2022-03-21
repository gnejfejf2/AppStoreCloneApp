//
//  TodatViewCoordinator.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit
class TodayViewCoordinator: BaseCoordinator {
    
    
    
    override func start() {
        let viewModel = TodayViewModel(builder: .init())
        let viewController = TodayViewController.instantiate()
        viewController.viewModel = viewModel
        let vc = UINavigationController(rootViewController: viewController)
        self.navigationController = vc
        
    }
  
    
}
