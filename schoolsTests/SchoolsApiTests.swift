//
//  SchoolsApiTests.swift
//  schoolsTests
//
//  Created by Emmanuel Oche on 12/1/21.
//

import XCTest
@testable import schools

class SchoolsApiTests: XCTestCase {
    
    var schoolsApi: SchoolsApi!
    var expectation: XCTestExpectation!
    
    override func setUp()  {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockUrlProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        schoolsApi = SchoolsApi(urlSession: urlSession)
        expectation = expectation(description: "Expectation")
    }
    
    //success load schools test case
    func test_ApiGetSchools_Success() throws {
        //setup mock http handler
        setUpApiSchoolRequestHandler()
        schoolsApi.loadSchoolData { (result) in
            switch result {
            case .success(let schools):
                XCTAssertEqual(schools.count, 1)
                let school = schools.first!
                XCTAssertEqual(school.dbn, dbn, "invalid dbn")
                XCTAssertEqual(school.school_name, school_name, "invalid name")
            case .failure(let error):
                XCTFail("error was not expected: \(error)")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    //failure load schools test case
    func test_ApiGetSchools_Failure() throws {
        //setup mock http handler
        setUpBadApiSchoolRequestHandler()
        schoolsApi.loadSchoolData { (result) in
            switch result {
            case .success(_):
                XCTFail("Success response was not expected.")
            case .failure(let error):
                guard let error = error as? ApiResponseError else {
                    XCTFail("Incorrect error received.")
                    self.expectation.fulfill()
                    return
                }
                //parsing error test
                XCTAssertEqual(error, ApiResponseError.parsing, "Parsing error was expected.")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    //success load sat scores test case
    func test_ApiGetSATScores_Success() throws {
        //setup mock http handler
        setUpApiSatDataRequestHandler()
        schoolsApi.loadSatData { (result) in
            switch result {
            case .success(let satData):
                XCTAssertEqual(satData.count, 1)
                let sat = satData.first!
                XCTAssertEqual(sat.dbn, dbn, "invalid dbn")
                XCTAssertEqual(sat.school_name, school_name, "invalid name")
                XCTAssertEqual(sat.num_of_sat_test_takers, testTakers, "invalid test takers")
            case .failure(let error):
                XCTFail("error was not expected: \(error)")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    //failure load schools test case
    func test_ApiGetSATScores_Failure() throws {
        setUpBadApiSatRequestHandler()
        schoolsApi.loadSatData { (result) in
            switch result {
            case .success(_):
                XCTFail("Success response was not expected.")
            case .failure(let error):
                guard let error = error as? ApiResponseError else {
                    XCTFail("Incorrect error received.")
                    self.expectation.fulfill()
                    return
                }
                //parsing error test
                XCTAssertEqual(error, ApiResponseError.parsing, "Parsing error was expected.")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
}
