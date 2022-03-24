//
//  AppExtensionTests.swift
//  AppExtensionTests
//
//  Created by 강지윤 on 2022/03/20.
//

import XCTest
@testable import AppStoreCopyApp

class StringExtensionTest: XCTestCase {

    
    func test_distanceTimeCal() {
        
        let dateString:String = "2022-03-24 15:05:40"

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

        let date:Date = dateFormatter.date(from: dateString)!
        
        let tiems = ["2022-03-21T07:00:00Z".distanceTimeCal(nowTime: date),"2022-03-18T07:00:00Z".distanceTimeCal(nowTime: date),"2022-03-10T07:00:00Z".distanceTimeCal(nowTime: date)]
        
        
        
        XCTAssertEqual(tiems, ["3일 전","6일 전","3월 10일"])
    }
    
    
    func testStringToDate(){
        let dateString = "2020-12-01T18:08:19.000+09:00"
//        dateString.toDate()
       
        
        XCTAssert(dateString.to_ISO_8601_Date()!.to_ISO_8601_Date_String() == "2020-12-01", dateString.to_ISO_8601_Date()!.to_ISO_8601_Date_String())
    }
    
    func test_image_direction() {
        let urlVertical = "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/55/d6/be/55d6be52-cfd7-df37-2e27-847db2c7eefc/175deb8d-5b3b-4e77-9790-4014647c918d_1.png/392x696bb.png"
        
        let urlHoriziontal = "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/55/d6/be/55d6be52-cfd7-df37-2e27-847db2c7eefc/175deb8d-5b3b-4e77-9790-4014647c918d_1.png/696x392bb.png"
        
        let item = [urlVertical.imageDirectionReturn() , urlHoriziontal.imageDirectionReturn()]
        let item2 : [ImageDirection] = [.Vertical , .Horiziontal]
        XCTAssertEqual(item, item2)
    }
    
   
    func test_round_test(){
        let item = [123.056.customRounds(count: 0),123.056.customRounds(count: 1),123.056.customRounds(count: 2)]
        let item2 =  [123.0 , 123.1 , 123.06]
        
        
    
        XCTAssertEqual(item, item2)
    }
    

}
