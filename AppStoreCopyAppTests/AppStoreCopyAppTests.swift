//
//  AppStoreCopyAppTests.swift
//  AppStoreCopyAppTests
//
//  Created by 강지윤 on 2022/03/20.
//

import XCTest
@testable import AppStoreCopyApp

class AppStoreCopyAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let url = "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource126/v4/55/d6/be/55d6be52-cfd7-df37-2e27-847db2c7eefc/175deb8d-5b3b-4e77-9790-4014647c918d_1.png/392x696bb.png"
        
        let components = url.components(separatedBy: "/")
        components.last?.components(separatedBy: "x")
        let imageSizeString = components.last?.components(separatedBy: "x")
        
        let width = imageSizeString?.first
        let height = imageSizeString?.last?.filter{ $0.isNumber }
        
        XCTAssertEqual(components.last, "392x696bb.png")
    }
    func testRoundTest(){
        let item = 123.056
        
    
        XCTAssertEqual(123.06, item.customRounds(count: 2))
    }
    


}
