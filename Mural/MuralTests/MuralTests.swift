//
//  MuralTests.swift
//  MuralTests
//
//  Created by Kaique de Souza Monteiro on 12/08/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

import UIKit
import XCTest

class MuralTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInstagramAssync() {
        // This is an example of a functional test case.
        let expectation = self.expectationWithDescription("Não foi né")
        
        InstagramRequest.getPhotos { (image) -> Void in
            expectation.fulfill()
            XCTAssertTrue(true, "Instagram didn't respond")
        }
        
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
}
