//
//  SearchViewController.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//
import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxDataSources

class SearchViewController : SuperViewControllerSetting<SearchViewModel>{
    
    @IBOutlet weak var noSearchTableView: UITableView!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil).then{
        $0.searchBar.placeholder = "게임, 앱, 스토리 등"
        $0.searchBar.autocapitalizationType = .none
        $0.searchBar.setValue("취소", forKey: "cancelButtonText")
    }
    
    
    
    private var sectionTableDatasource = RxTableViewSectionedReloadDataSource<SectionModel>(
        configureCell: { (dataSource, tableView, indexPath, item) in
            switch item {
            case .Keyword(let keyword) :
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchKeywordTableViewCell.id, for: indexPath) as! SearchKeywordTableViewCell
                cell.itemSetting(item: keyword)
                cell.selectionStyle = .none
                cell.selectedBackgroundView = .none
                
                return cell
            case .App(let keyword) :
                let cell = tableView.dequeueReusableCell(withIdentifier: GameAppTableViewCell.id, for: indexPath) as! GameAppTableViewCell
                cell.itemSetting(item: keyword)
                
                cell.selectionStyle = .none
                cell.selectedBackgroundView = .none
                return cell
            }
        }, titleForHeaderInSection: { dataSource, index in
            let sectionModel = dataSource.sectionModels[index]
            return "\(sectionModel.name)"
        })
    
    private var viewDidLoad = PublishSubject<Void>()
    
 
    
    override func uiDrawing() {
        navigationItem.title = "검색"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
       
        noSearchTableView.register(UINib(nibName: SearchKeywordTableViewCell.id, bundle: nil), forCellReuseIdentifier: SearchKeywordTableViewCell.id)
        noSearchTableView.register(UINib(nibName: GameAppTableViewCell.id, bundle: nil), forCellReuseIdentifier: GameAppTableViewCell.id)
        noSearchTableView.contentInsetAdjustmentBehavior = .never
        
        
        searchTableView.register(UINib(nibName: SearchAppVerticalTableViewCell.id, bundle: nil), forCellReuseIdentifier: SearchAppVerticalTableViewCell.id)
        searchTableView.register(UINib(nibName: SearchAppHoriziontalTableViewCell.id, bundle: nil), forCellReuseIdentifier: SearchAppHoriziontalTableViewCell.id)
       
        searchTableView.isHidden = true
        searchTableView.contentInsetAdjustmentBehavior = .never
    }
    
    
    override func uiSetting() {
        
        noSearchTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    override func viewModelBinding() {
        let searchActionInput = PublishSubject<String?>()

        searchActionInput
            .asDriverOnErrorNever()
            .drive(searchController.searchBar.rx.text)
            .disposed(by: disposeBag)


        let searchActionEditing = searchController.searchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .map{ [weak self] event -> Void in
                guard let self = self else { return }
                self.searchController.searchBar.resignFirstResponder()
            }
            .withLatestFrom(searchController.searchBar.rx.text)


        let searchAction = Observable.of(searchActionInput , searchActionEditing)
            .merge()
            .asDriverOnErrorNever()


        let cancelAction = searchController.searchBar.rx.cancelButtonClicked
            .asDriverOnErrorNever()


        let output = viewModel.transform(input: .init(
            viewDidLoad: viewDidLoad.asDriverOnErrorNever(),
            searchAction: searchAction,
            cancelAction : cancelAction
        ))

        noSearchTableView.rx
            .itemSelected
            .filter{ $0[0] == 0 }
            .withLatestFrom(output.noSearchData) { ($0 , $1) }
            .subscribe{ [weak self]  indexPath , datas in
                guard let self = self else { return }
                self.searchController.isActive = true
                self.searchController.searchBar.rx.text.onNext(datas[0].items[indexPath[1]].returnKeyword())
                searchActionInput.onNext(datas[0].items[indexPath[1]].returnKeyword())
            }
            .disposed(by: disposeBag)

        output.noSearchData
            .drive(noSearchTableView.rx.items(dataSource: sectionTableDatasource))
            .disposed(by: disposeBag)

        output.searchData
            .drive(searchTableView.rx.items){(tv , row , item) in
                if item.screenshotUrls[0].imageDirectionReturn() == .Vertical {
                    let cell = tv.dequeueReusableCell(withIdentifier: SearchAppVerticalTableViewCell.id) as! SearchAppVerticalTableViewCell
                    cell.itemSetting(item: item)
                    return cell
                }else{
                    let cell = tv.dequeueReusableCell(withIdentifier: SearchAppHoriziontalTableViewCell.id) as! SearchAppHoriziontalTableViewCell

                    cell.itemSetting(item: item)
                    return cell
                }

            }
            .disposed(by: disposeBag)

        output.searchData

            .map{ $0.count == 0 }
            .drive(searchTableView.rx.isHidden)
            .disposed(by: disposeBag)




        viewDidLoad.onNext(())
    }
//
//
}

extension SearchViewController : UITableViewDelegate {
    
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if(tableView == noSearchTableView){
            (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            (view as! UITableViewHeaderFooterView).textLabel?.textColor = .primaryColor
            (view as! UITableViewHeaderFooterView).textLabel?.sizeToFit()
        }
        
        
        
    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(tableView == noSearchTableView){
            return 40
        }else{
            return 0
        }
    }

    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = .primaryColorReverse
     }

    
}