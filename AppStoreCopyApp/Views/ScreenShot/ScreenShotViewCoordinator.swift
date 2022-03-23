//
//  ScreenShowViewCoordinator.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/23.
//

import Foundation

class ScreenShotViewCoordinator : BaseCoordinator {
    
    var appData : AppModel?
    var selectIndex : Int?
    override func start() {
       
        guard let appData = appData else {
            return
        }
        guard let selectIndex = selectIndex else {
            return
        }

        let viewModel = ScreenShotViewModel(builder: .init(
            appData: appData,
            selectIndex: selectIndex,
            coordinator : self
        ))
        let viewController = ScreenShotViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController.present(viewController, animated: true)
        
       
    }

    func dismiss(){
        navigationController.dismiss(animated: true)
        
    }
    
    
}


