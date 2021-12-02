//
//  Helpers.swift
//  schoolsTests
//
//  Created by Emmanuel Oche on 12/1/21.
//

import Foundation
@testable import schools

let apiSchoolsEndpoint = URL(string: SCHOOLS_API_ENDPOINT)!
let apiSatEndpoint = URL(string: SAT_API_ENDPOINT)!

let dbn = "02M260"
let school_name = "Clinton School Writers & Artists, M.S. 260"
let testTakers = "30"
let data = Data()

func setUpApiSchoolRequestHandler() {
    let jsonString = """
                     [
                         {
                            "dbn":"\(dbn)",
                            "school_name":"\(school_name)"
                         },
                     ]
                     """
    let data = jsonString.data(using: .utf8)
    //setup request handler
    MockUrlProtocol.requestHandler = { request in
        guard let url = request.url, url == apiSchoolsEndpoint else {
            throw ApiResponseError.request
        }
        
        let response = HTTPURLResponse(url: apiSchoolsEndpoint, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (response, data)
    }
}

func setUpApiSatDataRequestHandler() {
    let jsonString = """
                     [
                         {
                            "dbn":"\(dbn)",
                            "school_name":"\(school_name)",
                            "num_of_sat_test_takers":"\(testTakers)"
                         },
                     ]
                     """
    let data = jsonString.data(using: .utf8)
    
    MockUrlProtocol.requestHandler = { request in
        guard let url = request.url, url == apiSatEndpoint else {
            throw ApiResponseError.request
        }
        
        let response = HTTPURLResponse(url: apiSatEndpoint, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (response, data)
    }
}

func setUpBadApiSchoolRequestHandler() {
    MockUrlProtocol.requestHandler = { request in
        guard let url = request.url, url == apiSchoolsEndpoint else {
            throw ApiResponseError.request
        }
        
        let response = HTTPURLResponse(url: apiSchoolsEndpoint, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (response, data)
    }
}

func setUpBadApiSatRequestHandler() {
    MockUrlProtocol.requestHandler = { request in
        guard let url = request.url, url == apiSatEndpoint else {
            throw ApiResponseError.request
        }
        
        let response = HTTPURLResponse(url: apiSatEndpoint, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (response, data)
    }
}
