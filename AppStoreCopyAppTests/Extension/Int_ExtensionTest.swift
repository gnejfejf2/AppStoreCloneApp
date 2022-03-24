//
//  Int_ExtensionTest.swift
//  AppStoreCopyAppTests
//
//  Created by 강지윤 on 2022/03/24.
//

import XCTest
@testable import AppStoreCopyApp

class Int_ExtensionTests: XCTestCase {

   
    func test_Count_To_String(){
        let item = [12030.countToString(),1234.countToString(),123.countToString()]
        let item2 =  ["1.2 만" , "1.2 천" , "123"]
        
        
    
        XCTAssertEqual(item, item2)
    }
    

}
