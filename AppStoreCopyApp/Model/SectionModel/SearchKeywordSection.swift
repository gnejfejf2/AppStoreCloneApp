//
//  SearchKeywordSection.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//
import RxDataSources

enum SectionModel {
    case Keyword(items: [SectionItem])
    case App(items: [SectionItem])
}

enum SectionItem {
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

extension SectionModel: SectionModelType {
    
    typealias Item = SectionItem
    
    var name : String {
        switch self {
        case .Keyword :
            return "새로운 발견"
        case .App:
            return "추천 앱과 게임"
        }
    }
    
    var items: [SectionItem] {
        switch self {
        case .Keyword(items: let items):
            return items.map { $0 }
        case .App(items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: SectionModel, items: [Item]) {
        switch  original {
        case .Keyword(items: _):
            self = .Keyword(items: items)
        case .App(items: _):
            self = .App(items: items)
        }
    }
}
