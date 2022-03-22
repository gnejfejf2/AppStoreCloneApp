//
//  AppDetailViewCooridnator.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import Foundation

class AppDetailViewCoordinator: BaseCoordinator {
    
    var appData : AppModel?
    
    
    override func start() {
        guard let appData = appData else {return  }

        let viewModel = AppDetailViewModel(builder: .init(
            appData: appData,
            coordinator: self
        ))
        let viewController = AppDetailViewController.instantiate()
        viewController.viewModel = viewModel
       
        navigationController.pushViewController(viewController, animated: true)
        
       
    }
  
    
}
