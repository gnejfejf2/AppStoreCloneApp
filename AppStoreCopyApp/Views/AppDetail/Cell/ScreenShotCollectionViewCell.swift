//
//  screenShotCollectionViewCell.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import UIKit
import SnapKit


class ScreenShotCollectionViewCell: UICollectionViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    @IBOutlet weak var imageView: UIImageView!
    
    var item: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uiSetting()
    }

    
    func uiSetting() {
      
        
        backgroundColor = .primaryColorReverse
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
    }

    func itemSetting(item: String) {
        self.item = item
        imageView.setImageUrl(item)
    }

}
