//
//  AppExtensionTests.swift
//  AppExtensionTests
//
//  Created by 강지윤 on 2022/03/20.
//

import XCTest
@testable import AppStoreCopyApp

class AppExtensionTests: XCTestCase {

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
