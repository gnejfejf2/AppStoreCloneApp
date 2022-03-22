//
//  Int_Extension.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/21.
//

import Foundation

extension Int{
    func countToString() -> String{
        if(self >= 10000){

            return "\((Double(self) / 10000).rounded()) 만"
            
        }else if(self >= 1000){
            
            return "\((Double(self) / 1000).customRounds(count: 1)) 천"
            
        }else{
            
            return "\(self)"
            
        }
    }
}
