//
//  ScrennShowViewModel.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/23.
//

import RxSwift
import RxCocoa
import RxRelay

class ScreenShotViewModel : ViewModelBuilderProtocol {
    
    struct Input {
        let closeAction : Driver<UITapGestureRecognizer>
    }
    
    struct Output {
        let selectedIndex : Int
        let screenShotURLs : Driver<[String]>
    }
    
    struct Builder {
        let appData : AppModel
        let selectIndex : Int
        let coordinator : ScreenShotViewCoordinator
    }
    
    let builder : Builder
    let networkAPI : NetworkServiceProtocol
    let disposeBag = DisposeBag()
    
    
    required init(networkAPI: NetworkServiceProtocol = NetworkingAPI.shared, builder: Builder) {
        self.networkAPI = networkAPI
        self.builder = builder
    }
    
    func transform(input: Input) -> Output {
        let screenShotURLs = BehaviorSubject<[String]>(value: builder.appData.screenshotUrls)
        
        
        input.closeAction
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.builder.coordinator.dismiss()
            })
            .disposed(by: disposeBag)
          
//            .disposed(by : disposeBag)
        
        return .init(
            selectedIndex : builder.selectIndex ,
            screenShotURLs : screenShotURLs.asDriverOnErrorNever()
        )
    }
    
}
