//
//  Date_Extension.swift
//  AppStoreCopyApp
//
//  Created by 강지윤 on 2022/03/24.
//

import Foundation

extension Date {
    func to_ISO_8601_Date_String() -> String{
        let date = self

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-dd"
        dateFormatter.string(from: date)
        
        return dateFormatter.string(from: date)
    }
}
