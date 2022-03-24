//
//  SearchViewModel.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import RxSwift
import RxCocoa
import RxRelay

class SearchViewModel : ViewModelBuilderProtocol {
    
    struct Input {
        let viewDidLoad : Driver<Void>
        let searchAction : Driver<String?>
        let cancelAction : Driver<Void>
        let appTapAction : Driver<IndexPath>
        let searchAppTapAction : Driver<AppModel>
    }
    
    struct Output {
        let noSearchData : Driver<[SearchViewSectionModel]>
        let searchData : Driver<[AppModel]>
        let searchAction : Driver<Bool>
        let outputError : Driver<Error>
        let loading : Driver<Bool>
    }
    struct Builder {
        let coordinator : SearchViewCoordinator
    }
    
    let builder : Builder
    let errorTracker = ErrorTracker()
    let activityIndicator = ActivityIndicator()
    let networkAPI : NetworkServiceProtocol
    let disposeBag = DisposeBag()
    
    
    required init(networkAPI: NetworkServiceProtocol = NetworkingAPI.shared, builder: Builder) {
        self.networkAPI = networkAPI
        self.builder = builder
    }
    
    
    func transform(input: Input) -> Output {
        let noSearchData = BehaviorSubject<[SearchViewSectionModel]>(value: [.Keyword(items: []),.App(items: [])])
        let searchData = PublishSubject<[AppModel]>()
        let searchAction = PublishSubject<Bool>()
        let outputError = PublishSubject<Error>()
        let loading = PublishSubject<Bool>()
                                                        
        let viewDidLoad = input.viewDidLoad
                                .asObservable()
                                .share()
        
        let newItem = viewDidLoad
            .map{ _ -> [String] in
                return ["발견","카트라이더","포도알","게임"]
            }

        let recommendGame =  viewDidLoad
            .flatMap { [weak self]  _ -> Observable<RecomendSearchResponse> in
                guard let self = self else { return .never() }
                return self.networkAPI.fetchRepositories(type: RecomendSearchResponse.self, .SERARCH_RECOMEND_APP(term: "game"))
                    .trackError(self.errorTracker)
                    .trackActivity(self.activityIndicator)
                    .catch{ error in
                        return .never()
                    }
            }
            .map{ $0.results }
           
        
        Observable
            .combineLatest(newItem, recommendGame){ ($0 , $1) }
            .subscribe(onNext: { (newItem, recommendGame) in
                var keywordSectionItem : [SearchSectionItem] = []
                newItem.forEach{
                    keywordSectionItem.append(.Keyword(keyword: $0))
                }
                
                var recommendGameSectionItems : [SearchSectionItem] = []
                recommendGame.forEach{
                    recommendGameSectionItems.append(.App(appModel: $0))
                }
                noSearchData.onNext([.Keyword(items: keywordSectionItem),.App(items: recommendGameSectionItems)])
            })
            .disposed(by: disposeBag)
        

        
            
        let searchResult = input.searchAction
            .asObservable()
            .compactMap{ $0 }
            .flatMap { [weak self]  keyword -> Observable<RecomendSearchResponse> in
                guard let self = self else { return .never() }
                return self.networkAPI.fetchRepositories(type: RecomendSearchResponse.self, .SERARCH_RECOMEND_APP(term: keyword))
                    .trackError(self.errorTracker)
                    .trackActivity(self.activityIndicator)
                    .catch{ error in
                        return .never()
                    }
            }
            .share()
            
        searchResult
            .map{ $0.results }
            .subscribe(searchData)
            .disposed(by: disposeBag)
        
        searchResult
            .map{ $0.results.count != 0 }
            .subscribe(searchAction)
            .disposed(by: disposeBag)
        
        let cancelAction = input.cancelAction
            .asObservable()
            .map{ _ -> [AppModel] in return []  }
            .share()
        
        cancelAction
            .subscribe(searchData)
            .disposed(by: disposeBag)
        
        cancelAction
            .map{ _ in return true  }
            .subscribe(searchAction)
            .disposed(by: disposeBag)
        
        
        input.appTapAction
            .asObservable()
            .withLatestFrom(noSearchData) { ($0 , $1) }
            .subscribe{ [weak self]  indexPath , datas in
                guard let self = self else { return }
                guard let appData = datas[1].items[indexPath[1]].returnAppModel() else { return }
                self.builder.coordinator.openDetailView(appData: appData)
            }
            .disposed(by: disposeBag)
        
        input.searchAppTapAction
            .asObservable()
            .subscribe(onNext: { [weak self]  data in
                guard let self = self else { return }
                self.builder.coordinator.openDetailView(appData: data)
            })
            .disposed(by: disposeBag)
        
        
        errorTracker
            .asDriver()
            .drive(outputError)
            .disposed(by: disposeBag)
        
        activityIndicator
           .asDriver()
            .drive(loading)
            .disposed(by: disposeBag)
        
        
        return .init(
            noSearchData: noSearchData.asDriverOnErrorNever(),
            searchData : searchData.asDriverOnErrorNever(),
            searchAction: searchAction.asDriverOnErrorNever(),
            outputError : outputError.asDriverOnErrorNever(),
            loading : loading.asDriverOnErrorNever()
        )
    }
    
}
