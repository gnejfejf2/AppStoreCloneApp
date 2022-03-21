//
//  AppTopInfomationView.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import Foundation
import UIKit
@IBDesignable
class AppTopInformationView : UIView{
    static var id : String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    
 
    @IBOutlet var routeView: UIView!
    
    @IBOutlet weak var IconImageView: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var TypeLabel: UILabel!
    
    @IBOutlet weak var StatStackView: UIStackView!
    @IBOutlet weak var StarCountLabel: UILabel!
    
    @IBOutlet weak var DownloadButton: UIButton!
    
    
    
    
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
        IconImageView.layer.masksToBounds = true
        IconImageView.layer.cornerRadius = 8
        
        DownloadButton.layer.masksToBounds = true
        DownloadButton.layer.cornerRadius = DownloadButton.frame.height / 2
    }
    
    func itemSetting(item : AppModel?) {
     
        guard let item = item else { return }
        IconImageView.setImageUrl(item.artworkUrl60)
        TitleLabel.text = item.trackName
        TypeLabel.text = item.trackCensoredName
    }
    
    
}


protocol CustomViewProtocol {
    func loadViewFromNib()
    func uiSetting()
}


