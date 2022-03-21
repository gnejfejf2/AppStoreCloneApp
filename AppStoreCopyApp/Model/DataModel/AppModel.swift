//
//  AppModel.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import Foundation

// MARK: - Result
struct AppModel: Codable {
    var screenshotUrls : [String]
    var artworkUrl60 : String
    var advisories : [String]
    var minimumOsVersion : String
    var trackCensoredName : String
    var contentAdvisoryRating : String
    var trackName : String
    var sellerName : String
    var description : String
    var genres : [String]
    var version : String
}
