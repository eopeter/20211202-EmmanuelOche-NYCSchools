//
//  schoolsUITests.swift
//  schoolsUITests
//
//  Created by Emmanuel Oche on 12/1/21.
//

import XCTest
@testable import schools

//more UI tests could be added to verify that the UI will always word as designed
class schoolsUITests: XCTestCase {
    
    let school_name = "Clinton School Writers & Artists, M.S. 260"
    
    override func setUpWithError() throws {
        //setup api
        
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    // tests that can correctly load the school to the listview
    // this test is failing because not enough time to implement mock viewModel
    func test_SchoolName_Success() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        //mockApiProtocol need to be injected
        let hasSchoolName = app.tables.cells.staticTexts[school_name].exists
        XCTAssertTrue(hasSchoolName)

    }
    //performance test to measure load time
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
