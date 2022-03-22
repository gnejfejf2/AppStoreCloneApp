//
//  SearchKeywordTableViewCell.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit

class SearchKeywordTableViewCell: UITableViewCell , CellSettingProtocl {
    
    

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    @IBOutlet weak var searchKeywordLabel: UILabel!
    
    var item: String?
    
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

    func itemSetting(item: String) {
        self.item = item
        searchKeywordLabel.text = item
    }
    
    
}
