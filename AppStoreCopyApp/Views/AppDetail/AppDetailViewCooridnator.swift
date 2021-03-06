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
    
    func screenShotView(appData : AppModel , selectIndex : Int){
        let coordinator = ScreenShotViewCoordinator(navigationController: navigationController)
        coordinator.appData = appData
        coordinator.selectIndex = selectIndex
        coordinator.start()
    }
    
    func versionHistoryView(appData : AppModel){
        let coordinator = VersionListViewCoordinator(navigationController: navigationController)
        coordinator.appData = appData
        coordinator.start()
        
    }
  
    
}
