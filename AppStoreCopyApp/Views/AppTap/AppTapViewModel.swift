//
//  AppTapViewModel.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import RxSwift
import RxCocoa
import RxRelay

class AppTapViewModel : ViewModelBuilderProtocol {
    
    struct Input {
    
    }
    
    struct Output {
    
    }
    
    struct Builder {
        
    }
    
    let builder : Builder
    let networkAPI : NetworkServiceProtocol
    let disposeBag = DisposeBag()
    
    
    required init(networkAPI: NetworkServiceProtocol = NetworkingAPI.shared, builder: Builder) {
        self.networkAPI = networkAPI
        self.builder = builder
    }
    
    
    func transform(input: Input) -> Output {
        
        return .init()
    }
    
}
