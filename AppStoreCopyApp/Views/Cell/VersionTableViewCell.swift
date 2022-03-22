//
//  VersionTableViewCell.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import UIKit

class VersionTableViewCell: UITableViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    @IBOutlet weak var versionDescriptionLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        readMoreButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(readMore)))
        readMoreButton.isUserInteractionEnabled = true
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        
        
    }
    
    
    @objc func readMore(){
        versionDescriptionLabel.numberOfLines = 0
        reloadInputViews()
    }
    
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()

        return label.frame.height
    }
    
}


