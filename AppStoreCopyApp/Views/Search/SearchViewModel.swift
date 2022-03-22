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
//        let searchKeyword : Driver<String>
        let searchAction : Driver<String?>
        let cancelAction : Driver<Void>
        let appTapAction : Driver<IndexPath>
        let searchAppTapAction : Driver<AppModel>
    }
    
    struct Output {
        let noSearchData : Driver<[SectionModel]>
        let searchData : Driver<[AppModel]>
        
    }
    struct Builder {
        let cordinator : SearchViewCoordinator
    }
    
    let builder : Builder
    let networkAPI : NetworkServiceProtocol
    let disposeBag = DisposeBag()
    
    
    required init(networkAPI: NetworkServiceProtocol = NetworkingAPI.shared, builder: Builder) {
        self.networkAPI = networkAPI
        self.builder = builder
    }
    
    
    func transform(input: Input) -> Output {
        let noSearchData = BehaviorSubject<[SectionModel]>(value: [.Keyword(items: []),.App(items: [])])
        let searchData = PublishSubject<[AppModel]>()
                                                        
                                                             
                                                        
        
        
        input.viewDidLoad
            .asObservable()
            .map{ _ -> [String] in
                return ["발견","카트라이더","포도알","게임"]
            }
            .withLatestFrom(noSearchData) { ($0 , $1) }
            .subscribe(onNext: { (keywords, data) in
                var original = data
                var keywordSectionItem : [SectionItem] = []
                keywords.forEach{
                    keywordSectionItem.append(.Keyword(keyword: $0))
                }
                original[0] = .Keyword(items: keywordSectionItem)
                noSearchData.onNext(original)
            })
            .disposed(by: disposeBag)
        
        input.viewDidLoad
            .asObservable()
            .flatMap { [weak self]  _ -> Observable<RecomendSearchResponse> in
                guard let self = self else { return .never() }
                return self.networkAPI.fetchRepositories(type: RecomendSearchResponse.self, .SERARCH_RECOMEND_APP(term: "game"))
                    .catch{ error in
                        return .never()
                    }
            }
            .withLatestFrom(noSearchData) { ($0 , $1) }
            .subscribe(onNext: { (appDatas, data) in
                var original = data
                var keywordSectionItem : [SectionItem] = []
                appDatas.results.forEach{
                    keywordSectionItem.append(.App(appModel: $0))
                }
                original[1] = .App(items: keywordSectionItem)
                noSearchData.onNext(original)
            })
            .disposed(by: disposeBag)

        
            
        input.searchAction
            .asObservable()
            .filter{ $0 != nil }
            .flatMap { [weak self]  keyword -> Observable<RecomendSearchResponse> in
                guard let self = self else { return .never() }
                return self.networkAPI.fetchRepositories(type: RecomendSearchResponse.self, .SERARCH_RECOMEND_APP(term: keyword!))
                    .catch{ error in
                        return .never()
                    }
            }
            .map{ $0.results }
            .subscribe(searchData)
            .disposed(by: disposeBag)
        
        
        input.cancelAction
            .asObservable()
            .map{ _ -> [AppModel] in return []  }
            .subscribe(searchData)
            .disposed(by: disposeBag)
        
        input.appTapAction
            .asObservable()
            .withLatestFrom(noSearchData) { ($0 , $1) }
            .subscribe{ [weak self]  indexPath , datas in
                guard let self = self else { return }
                guard let appData = datas[1].items[indexPath[1]].returnAppModel() else { return }
                self.builder.cordinator.openDetailView(appData: appData)
            }
            .disposed(by: disposeBag)
        
        input.searchAppTapAction
            .asObservable()
            .subscribe(onNext: { [weak self]  data in
                guard let self = self else { return }
                self.builder.cordinator.openDetailView(appData: data)
            })
            .disposed(by: disposeBag)
        
        
        return .init(
            noSearchData: noSearchData.asDriverOnErrorNever(),
            searchData : searchData.asDriverOnErrorNever()
        )
    }
    
}
