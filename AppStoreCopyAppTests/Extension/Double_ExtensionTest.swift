//
//  IntExtensionTests.swift
//  AppStoreCopyAppTests
//
//  Created by 강지윤 on 2022/03/24.
//


import XCTest
@testable import AppStoreCopyApp

class Double_ExtensionTests: XCTestCase {

   
    func test_round_test(){
        let item = [123.056.customRounds(count: 0),123.056.customRounds(count: 1),123.056.customRounds(count: 2)]
        let item2 =  [123.0 , 123.1 , 123.06]
        
        
    
        XCTAssertEqual(item, item2)
    }
    

}
