//
//  SearchAppTableViewCell.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit

class SearchAppVerticalTableViewCell: UITableViewCell , CellSettingProtocl {
    
    
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    @IBOutlet weak var appTopInformationView: AppTopInformationView!
    @IBOutlet weak var ScreenShotImageView1: UIImageView!
    @IBOutlet weak var ScreenShotImageView2: UIImageView!
    @IBOutlet weak var ScreenShotImageView3: UIImageView!
    
    @IBOutlet weak var imageAspect: NSLayoutConstraint!
    lazy var screenShotImages : [UIImageView] = [ScreenShotImageView1,ScreenShotImageView2,ScreenShotImageView3]
    
    
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
       
        screenShotImages.forEach{
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 8
        }
     
       
    }
    
    func itemSetting(item : AppModel) {
        self.item = item
        guard let item = self.item else { return }
        appTopInformationView.itemSetting(item: item)
        
        for (index , item) in item.screenshotUrls.enumerated(){
            if(index > 2){
                break
            }
            screenShotImages[index].setImageUrl(item)
        }
    }
    
  
    
}
