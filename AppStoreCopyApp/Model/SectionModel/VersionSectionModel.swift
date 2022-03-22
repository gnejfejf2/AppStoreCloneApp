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


