//
//  String_Extension.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/18.
//

import Foundation

extension String{
    
    func to_ISO_8601_Date() -> Date?{
        let dateFormatter = DateFormatter()
//        "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
       
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    func imageDirectionReturn() -> ImageDirection {
        let url = self
        let components = url.components(separatedBy: "/")
        let imageSizeString = components.last?.components(separatedBy: "x")
        let width = Int(imageSizeString?.first ?? "") ?? 0
        let height = Int(imageSizeString?.last?.filter{ $0.isNumber } ?? "") ?? 0
        
        print(width)
        print(height)
        if(width > height){
            return .Horiziontal
        }else{
            return .Vertical
        }
        
        
        
    }
    
    
    
    
}
extension Date {
    func to_ISO_8601_Date_String() -> String{
        let date = self

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.string(from: date)
        
        return dateFormatter.string(from: date)
    }
}
