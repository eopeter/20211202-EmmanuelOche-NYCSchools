//
//  schoolsTests.swift
//  schoolsTests
//
//  Created by Emmanuel Oche on 12/1/21.
//

import XCTest
@testable import schools

class schoolsViewModelTests: XCTestCase {

    var schoolsApi: SchoolsApi!
    var schoolsViewModel: SchoolsViewModel!
    
    var expectation: XCTestExpectation!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockUrlProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        schoolsApi = SchoolsApi(urlSession: urlSession)
        schoolsViewModel = SchoolsViewModel.init(schoolsApiService: schoolsApi)
        expectation = expectation(description: "Expectation")
    }

    func test_LoadApiSchoolData_Success(){
        //set up the mock api request handler for getting schools
        setUpApiSchoolRequestHandler()
        //load the schools from api
        schoolsViewModel.loadSchoolData {
            XCTAssertFalse(self.schoolsViewModel.hasError)
            XCTAssertEqual(self.schoolsViewModel.schools.count, 1)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_LoadApiSatData_Success(){
        //set up the mock api request handler for getting sat scores
        setUpApiSatDataRequestHandler()
        //load the sat scores from api
        schoolsViewModel.loadSatData {
            XCTAssertEqual(self.schoolsViewModel.satLookUp.count, 1)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_LoadApiData_Failed(){
        schoolsViewModel.loadData()
    }
    
    func test_ReloadApiData_Success(){
        schoolsViewModel.reload()
    }
    
    func test_ReloadApiData_Failed(){
        schoolsViewModel.reload()
    }

}
