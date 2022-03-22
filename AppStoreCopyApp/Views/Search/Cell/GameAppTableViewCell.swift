//
//  GameAppTableViewCell.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit

class GameAppTableViewCell: UITableViewCell , CellSettingProtocl{
    
    
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    
    @IBOutlet weak var appTopInformationView: AppTopInformationView!
    
    var item : AppModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uiSetting()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        uiSetting()
    }
    
    
    func uiSetting() {
        backgroundColor = .primaryColorReverse
        selectionStyle = .none
        selectedBackgroundView = .none
    }
    
    func itemSetting(item : AppModel) {
        self.item = item
        guard let item = self.item else { return }
        appTopInformationView.itemSetting(item: item)
        appTopInformationView.statStackView.isHidden = true
    }
    
}
