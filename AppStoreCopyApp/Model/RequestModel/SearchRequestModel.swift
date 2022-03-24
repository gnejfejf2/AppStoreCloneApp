//
//  SearchRequestModel.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/24.
//

import Foundation
struct SearchRequestModel : Encodable {
    var term : String = "game"
    var entity : String = "software"
    var country : String = "KR"
    var lang : String = "KO"
    var limit : Int = 10
}
