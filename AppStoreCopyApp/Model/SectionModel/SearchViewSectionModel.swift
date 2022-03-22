//
//  SearchKeywordSection.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//
import RxDataSources

enum SearchViewSectionModel {
    case Keyword(items: [SearchSectionItem])
    case App(items: [SearchSectionItem])
}

enum SearchSectionItem {
    case Keyword(keyword: String)
    case App(appModel: AppModel)
    
    func returnData() -> String{
        switch self {
        case .Keyword(let keyword):
            return keyword
        case .App(let appModel):
            return appModel.trackName
        }
    }
    
    func returnAppModel() -> AppModel?{
        switch self {
        case .Keyword:
            return nil
        case .App(let appModel):
            return appModel
        }
        
    }
    
}

extension SearchViewSectionModel: SectionModelType {
    
    typealias Item = SearchSectionItem
    
    var name : String {
        switch self {
        case .Keyword :
            return "새로운 발견"
        case .App:
            return "추천 앱과 게임"
        }
    }
    
    var items: [SearchSectionItem] {
        switch self {
        case .Keyword(items: let items):
            return items.map { $0 }
        case .App(items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: SearchViewSectionModel, items: [Item]) {
        switch  original {
        case .Keyword(items: _):
            self = .Keyword(items: items)
        case .App(items: _):
            self = .App(items: items)
        }
    }
}
