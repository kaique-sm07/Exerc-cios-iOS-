//
//  MobyDickWordCountTests.swift
//  MobyDickWordCountTests
//
//  Created by Augusto Souza on 8/6/15.
//  Copyright (c) 2015 Augusto. All rights reserved.
//

import UIKit
import XCTest

class MobyDickWordCountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceWordcounterWordSplitter() {
        var i = 0
        self.measureBlock() {
            let wordCounter = WordCounter(resourceName: "test_sample", resourceType: "txt")
            wordCounter.content.words
            
            println("exec \(i++)")
        }
    }
    
    func testPerformanceWordcounterSync() {
        var i = 0
        self.measureBlock() {
            let wordCounter = WordCounter(resourceName: "test_sample", resourceType: "txt")
            wordCounter.execute()
            
            println("exec \(i++)")
        }
    }

    func testPerformanceWordcounterAsync() {
        var i = 0
        self.measureBlock() {
            let wordCounter = WordCounter(resourceName: "test_sample", resourceType: "txt")
//            wordCounter.executeAsync({ (w) -> Void in
//                println("exec \(i++)")
//            })
        }
    }

}
