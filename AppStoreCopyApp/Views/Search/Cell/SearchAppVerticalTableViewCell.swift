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
    @IBOutlet weak var screenShotImageView1: UIImageView!
    @IBOutlet weak var screenShotImageView2: UIImageView!
    @IBOutlet weak var screenShotImageView3: UIImageView!
    
    @IBOutlet weak var imageAspect: NSLayoutConstraint!
    lazy var screenShotImages : [UIImageView] = [screenShotImageView1,screenShotImageView2,screenShotImageView3]
    
    
    var item : AppModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uiSetting()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        uiSetting()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        appTopInformationView.iconImageView.image = nil
        screenShotImageView1.image = nil
        screenShotImageView2.image = nil
        screenShotImageView3.image = nil
       
        
    }
    
    
    func uiSetting() {
       
        screenShotImages.forEach{
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 8
        }
     
        selectionStyle = .none
        selectedBackgroundView = .none
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
