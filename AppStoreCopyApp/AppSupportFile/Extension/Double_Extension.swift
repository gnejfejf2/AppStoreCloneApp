//
//  Double_Extension.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import Foundation


extension Double {
    
    func customRounds(count : Int) -> Double{
        
        var pow = pow(Double(10), Double(count))
        
        var upPow = (self * pow).rounded()
        
        
        return upPow / pow
    }
    
    
}
