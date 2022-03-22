//
//  AppDetailViewModel.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import Foundation
import RxSwift
import RxCocoa

class AppDetailViewModel : ViewModelBuilderProtocol {
    
    struct Input {
    
    }
    
    struct Output {
        let appData : Driver<AppModel>
    }
    
    struct Builder {
        let appData : AppModel
        let coordinator : AppDetailViewCoordinator
    }
    
    let builder : Builder
    let networkAPI : NetworkServiceProtocol
    let disposeBag = DisposeBag()
    
    
    required init(networkAPI: NetworkServiceProtocol = NetworkingAPI.shared, builder: Builder) {
        self.networkAPI = networkAPI
        self.builder = builder
    }
    
    
    func transform(input: Input) -> Output {
        let appData = BehaviorSubject<AppModel>(value: builder.appData)
        
        
        return .init(
            appData: appData.asDriverOnErrorNever()
        )
    }
    
}
