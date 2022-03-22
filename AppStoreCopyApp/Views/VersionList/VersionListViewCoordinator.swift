//
//  VersionListViewCoordinator.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/22.
//

import Foundation

class VersionListViewCoordinator : BaseCoordinator {
    
    var appData : AppModel?
    
    override func start() {
       
        guard let appData = appData else {
            return
        }

        let viewModel = VersionListViewModel(builder: .init(
            appData : appData,
            coordinator: self
        ))
        let viewController = VersionListViewController.instantiate()
        viewController.viewModel = viewModel
       navigationController.pushViewController(viewController, animated: true)
        
       
    }
  
}

