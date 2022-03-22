//
//  VersionSectionModel.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/22.
//

import Foundation
import RxDataSources

struct VersionModelSection  {
    let name : String
    var items : [VersionModel]
}

extension VersionModelSection : AnimatableSectionModelType {
    typealias Identity = String
    typealias Item = VersionModel
    
    var identity: String {
        return name
    }
    
    
    init(original: VersionModelSection, items: [VersionModel]) {
        self = original
        self.items = items
    }
}

struct VersionModel {
    var version : String
    var currentVersionReleaseDate : String
    var releaseNotes : String?
   
}

extension VersionModel : IdentifiableType, Equatable {
    var identity: String {
        return UUID().uuidString
    }
}
