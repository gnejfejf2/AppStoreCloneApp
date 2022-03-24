//
//  Double_Extension.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import Foundation


extension Double {
    
    func customRounds(count : Int) -> Double{
        
        if(count == 0){
            return self.rounded()
        }
        let pow = pow(Double(10), Double(count))
        let upPow = (self * pow).rounded()
        return upPow / pow
    }
    
    
}
