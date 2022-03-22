//
//  StarSettingProtocol.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/22.
//

import UIKit

protocol StarSettingProtocol {
    var starViews : [UIImageView] { get set }
    
    func starSetting(item : AppModel)
}

extension StarSettingProtocol {
    func starSetting(item : AppModel){
        let upAreageRating = item.averageUserRating.customRounds(count: 1)
        
        if(item.trackName == "카카오뱅크"){
            return
        }
        for i in (1..<6).reversed(){
            if(upAreageRating >= Double(i)){
                break
            }else if(upAreageRating >= Double(i) - 0.5){
                starViews[i - 1].image = UIImage(systemName: "star.leadinghalf.filled")
                break
            }else{
                starViews[i - 1].image = UIImage(systemName: "star")
            }
        }
    }
}
