//
//  SearchAppHoriziontalTableViewCell.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit

class SearchAppHoriziontalTableViewCell: UITableViewCell , CellSettingProtocl {
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
   
    
    @IBOutlet weak var appTopInformationView: AppTopInformationView!
    @IBOutlet weak var ScreenShotImageView1: UIImageView!
    
    var item : AppModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uiSetting()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        uiSetting()
        // Configure the view for the selected state
    }
    
    
    func uiSetting() {
       
        ScreenShotImageView1.layer.masksToBounds = true
        ScreenShotImageView1.layer.cornerRadius = 8
      
    }
    
    func itemSetting(item : AppModel) {
        self.item = item
        guard let item = self.item else { return }
        
        appTopInformationView.itemSetting(item: item)
        ScreenShotImageView1.setImageUrl(item.screenshotUrls[0])
        
        
    }
    
}
