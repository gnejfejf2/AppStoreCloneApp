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
        
        if(width > height){
            return .Horiziontal
        }else{
            return .Vertical
        }
        
        
        
    }
    
    func distanceTimeCal(nowTime : Date = Date().addingTimeInterval(32400)) -> String{
        let getTimeDateFormatter = DateFormatter()
        
        getTimeDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        getTimeDateFormatter.locale = Locale(identifier: "ko_KR")
        getTimeDateFormatter.timeZone = TimeZone(abbreviation: "KST")
        let time = getTimeDateFormatter.date(from: self) ?? Date()
        
        var returnString : String = ""
        //현재시간중에서 날짜만 뽑아내고
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString:String = dayFormatter.string(from: nowTime)
        //시간을 00시 00분 00초 를 기준으로 만들어준다 이렇게하지않으면 날짜차이를 24시간 이내를 인식한다
        //단순 날짜만 비교하는것이아닌 시간까지 포함해서 비교를 해버려서 이렇게 바꿔버렸다.
        let dateFormatter = DateFormatter()
        //데이터포맷설정
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dayString = dateFormatter.date(from: "\(dateString) 00:00:00")
        let distanceMinute = Calendar.current.dateComponents([.minute], from: time, to: nowTime).minute!
        let distanceHour = Calendar.current.dateComponents([.hour], from:  time, to: nowTime).hour!
        let distanceDay = Calendar.current.dateComponents([.day], from:  time, to: dayString!).day!
        let distanceYear = Calendar.current.dateComponents([.year], from: time, to: nowTime).year!
        
        
        if (distanceYear >= 1){
            let withYeardateFormatter = DateFormatter()
            
            withYeardateFormatter.dateFormat = "yyyy년 M월 dd일"
            withYeardateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            
            returnString = withYeardateFormatter.string(from: time)
        }else if (distanceDay >= 7 && distanceYear < 1){
            let noYeardateFormatter = DateFormatter()
            
            noYeardateFormatter.dateFormat = "M월 dd일"
            noYeardateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            
            
            returnString = noYeardateFormatter.string(from: time)
        }else if (distanceHour >= 24 && distanceDay < 7){
            
            
            returnString =  "\(distanceDay)일 전"
        }else if (distanceMinute >= 60 && distanceHour < 24){
            returnString =  "\(distanceHour)시간 전"
        }else if (distanceMinute >= 1 && distanceMinute < 60){
            returnString = "\(distanceMinute)분 전"
        }else if(distanceMinute < 1){
            returnString = "츨시 전"
        }
        
        
        return returnString
    }
    
    
}
