//
//  ImageCasheManager.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit
class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
