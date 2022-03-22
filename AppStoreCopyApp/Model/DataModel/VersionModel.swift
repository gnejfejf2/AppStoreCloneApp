//
//  VersionModel.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/23.
//

import Foundation
import RxDataSources

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
