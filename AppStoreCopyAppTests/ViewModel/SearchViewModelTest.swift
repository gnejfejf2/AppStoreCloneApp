//
//  SearchViewModel.swift
//  AppStoreCopyAppTests
//
//  Created by 강지윤 on 2022/03/24.
//



import XCTest
import RxSwift
import RxCocoa
import RxTest

@testable import AppStoreCopyApp

class SearchViewModelTest: XCTestCase {
    let disposeBag = DisposeBag()
    var viewController : SearchViewController!
    var viewModel: SearchViewModel!
    var scheduler: TestScheduler!
    var viewDidLoad = PublishSubject<Void>()
    var searchAction = PublishSubject<String?>()
    var cancelAction = PublishSubject<Void>()
    var appTapAction = PublishSubject<IndexPath>()
    var searchAppTapAction = PublishSubject<AppModel>()
    var output : SearchViewModel.Output!
    
    // MARK: - GIVEN
    override func setUp() {
        let mockNetworkingAPI =  MockNetworking.shared
       
        let coordinaotr = SearchViewCoordinator(navigationController: UINavigationController())
        viewModel = SearchViewModel(networkAPI: mockNetworkingAPI , builder: .init(coordinator: coordinaotr))
        viewController = SearchViewController()
        viewController.viewModel = viewModel
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
       
     
        
        
        output = viewModel.transform(input: .init(
            viewDidLoad: viewDidLoad.asDriverOnErrorNever() ,
            searchAction: searchAction.asDriverOnErrorNever(),
            cancelAction: cancelAction.asDriverOnErrorNever(),
            appTapAction: appTapAction.asDriverOnErrorNever(),
            searchAppTapAction: searchAppTapAction.asDriverOnErrorNever())
        )
        
    }
   

    //ViewModel에 ViewDidLoad 이벤트가 발생했을때
    //새로운 발견 , 추천앱과 게임이 정상적으로 동작하는지 체크
    //두개의 이벤트는 동시에 일어나기에 합쳐서 방출해서 각각 체크
    func test_viewDidLoad(){

        let observer = scheduler.createObserver(Int.self)
        
       
        
        scheduler.createHotObservable([.next(100 , ())])
                    .bind(to: viewDidLoad)
                    .disposed(by: disposeBag)
        let noSearchData =  output.noSearchData
            .asObservable()
        
        
        noSearchData
            .map{ $0[0].items.count  }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        noSearchData
            .map{ $0[1].items.count  }
            .bind(to: observer)
            .disposed(by: disposeBag)
 
        scheduler.start()

        let exceptEvents: [Recorded<Event<Int>>] = [
            .next(0 , 0),
            .next(0 , 0),
            .next(100 , 4),
            .next(100 , 20)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }
    func test_카카오뱅크_Search(){

        let observer = scheduler.createObserver(Int.self)
        
       
        
        scheduler.createHotObservable([.next(100 , "카카오뱅크")])
                    .bind(to: searchAction)
                    .disposed(by: disposeBag)
        let searchData =  output.searchData
            .asObservable()
        
        
        searchData
            .map{ $0.count  }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
      
        scheduler.start()

        let exceptEvents: [Recorded<Event<Int>>] = [
            .next(100 , 20)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }

    func test_카카오뱅크_Search_Cancel(){

        let observer = scheduler.createObserver(Int.self)
        
       
        
        scheduler.createHotObservable([.next(100 , "카카오뱅크")])
                    .bind(to: searchAction)
                    .disposed(by: disposeBag)
        
        scheduler.createHotObservable([.next(200 , ())])
                    .bind(to: cancelAction)
                    .disposed(by: disposeBag)
        
        
        let searchData =  output.searchData
            .asObservable()
        
        
        searchData
            .map{ $0.count  }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
      
        scheduler.start()

        let exceptEvents: [Recorded<Event<Int>>] = [
            .next(100 , 20),
            .next(200 , 0)
        ]
        XCTAssertEqual(observer.events , exceptEvents)
    }
}
