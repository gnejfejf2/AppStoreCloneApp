//
//  AppTopInfomationView.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import Foundation
import UIKit
@IBDesignable
class AppTopInformationView : UIView , StarSettingProtocol{
   
    static var id : String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    
    
    @IBOutlet var routeView: UIView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var informationStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dommyView: UIView!
    @IBOutlet weak var statStackView: UIStackView!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    lazy var starViews : [UIImageView] = [star1,star2,star3,star4,star5]
    
    var item : AppModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        uiSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        uiSetting()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: AppTopInformationView.self)
        bundle.loadNibNamed("AppTopInformationView", owner: self, options: nil)
        addSubview(routeView)
        routeView.frame = self.bounds
        routeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func uiSetting(){
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 8
        
        downloadButton.layer.masksToBounds = true
        downloadButton.layer.cornerRadius = downloadButton.frame.height / 2
    }
    
    func itemSetting(item : AppModel?) {
        
        guard let item = item else { return }
        self.item = item
        iconImageView.setImageUrl(item.artworkUrl60)
        titleLabel.text = item.trackName
        typeLabel.text = item.primaryGenreName
        starCountLabel.text = item.userRatingCount.countToString()
        starSetting(item: item)
    }
    
    
    
}





