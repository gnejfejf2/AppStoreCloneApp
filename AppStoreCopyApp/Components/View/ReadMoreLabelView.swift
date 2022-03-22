//
//  ReadMoreLabelView.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import UIKit

class ReadMoreLabelView: UIStackView {
    static var id : String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    
    
    
    @IBOutlet var routeView: UIView!
    
    @IBOutlet weak var textView: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    
    var moreButtonAction : (() -> ())? = nil
    
    let defaultHegiht : CGFloat = 67
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        uiSetting()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        uiSetting()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: ReadMoreLabelView.self)
        bundle.loadNibNamed("ReadMoreLabelView", owner: self, options: nil)
        addSubview(routeView)
        routeView.frame = self.bounds
        routeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func uiSetting(){
        moreButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(readMore)))
      textView.setLinespace(spacing: 10)
    }
    
    func itemSetting(item : String?) {
        guard let item = item else {
            snp.makeConstraints { make in
                make.height.equalTo(0)
            }
            moreButton.isHidden = true
            return
            
        }
        if(item == ""){
            snp.makeConstraints { make in
                make.height.equalTo(0)
            }
            moreButton.isHidden = true
            return
        }
        
        
        textView.text = item
        
    
        if(defaultHegiht > heightForView(text: textView.text!, font: textView.font, width: textView.frame.width)){
            moreButton.isHidden = true
        }
    }

    
    @objc func readMore(){
        textView.numberOfLines = 0
        moreButton.isHidden = true
        moreButtonAction?()
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
