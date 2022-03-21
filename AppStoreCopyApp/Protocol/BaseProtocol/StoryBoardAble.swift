//
//  StoryBoardAble.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/20.
//

import UIKit

protocol Storyboardable {
    static func instantiate() -> Self
}


extension Storyboardable where Self : UIViewController {
    
    //ViewController를 바로 인스턴스화 할수있는 추가기능을 하는 함수인듯 사람들이 되게 많이 사용하는 함수같다
    //해당 코드는 자세하게 분석해볼 필요가있다.
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: className, bundle: Bundle.main)
      
        return storyboard.instantiateViewController(identifier: className)
    }
    
}
