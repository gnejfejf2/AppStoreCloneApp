//
//  VersionTableViewCell.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import UIKit
import SnapKit
import Then

protocol ReadMoreActionDelegate : AnyObject{
    func readMore(row : Int)
}

class VersionTableViewCell : UITableViewCell , CellSettingProtocl {
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
   
   
    var versionLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .placeholderText
    }
    
    var versionDateLable = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .placeholderText
    }
  
    
    var relaseLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 3
        $0.setLinespace(spacing: 2)
    }
    
    var moreButton = UIButton().then{
        $0.setTitle("더 보기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
    }
    
    let defaultHegiht : CGFloat = 55
    var item : VersionModel?
    var row : Int?
    weak var delegate : ReadMoreActionDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        uiSetting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        uiSetting()
    }
    
    deinit{
        delegate = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        relaseLabel.numberOfLines = 3
        moreButton.isHidden = false
        delegate = nil
    }
    
    func uiSetting() {
        selectionStyle = .none
        selectedBackgroundView = .none
        contentView.backgroundColor = .primaryColorReverse
        contentView.addSubview(versionLabel)
        contentView.addSubview(versionDateLable)
        contentView.addSubview(relaseLabel)
        contentView.addSubview(moreButton)
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        versionDateLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        relaseLabel.snp.makeConstraints { make in
            make.top.equalTo(versionDateLable.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.bottom.trailing.equalToSuperview().offset(-20)
        }
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-10)
        }
        moreButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(readMore)))
    }
    
   
    
    func itemSetting(item : VersionModel) {
        versionLabel.text = item.version
        versionDateLable.text = item.currentVersionReleaseDate.distanceTimeCal()
        relaseLabel.text = item.releaseNotes
        
        if(item.releaseNotes == "" || item.releaseNotes == nil){
            snp.makeConstraints { make in
                make.height.equalTo(0)
            }
            moreButton.isHidden = true
            return
        }
        
        
        if(defaultHegiht > relaseLabel.heightForView()){
            moreButton.isHidden = true
        }
    }

    
    @objc func readMore(){
        relaseLabel.numberOfLines = 0
        moreButton.isHidden = true
        guard let row = row else {
            return
        }

        delegate?.readMore(row: row)
    }
    

}


