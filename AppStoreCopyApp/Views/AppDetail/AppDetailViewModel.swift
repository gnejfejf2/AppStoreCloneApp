//
//  AppDetailViewModel.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxGesture
class AppDetailViewModel : ViewModelBuilderProtocol {
    
    struct Input {
        let versionHistoryAction : Driver<UITapGestureRecognizer>
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
        
        input.versionHistoryAction
            .withLatestFrom(appData.asDriverOnErrorNever()){ $1 }
            .drive{ [weak self] item in
                guard let self = self else { return }
                self.builder.coordinator.versionHistoryView(appData : item)
            }
            .disposed(by: disposeBag)
        
        
        return .init(
            appData: appData.asDriverOnErrorNever()
        )
    }
    
}
