//
//  POIRequestValidation_Test.swift
//  AdyenDemo_AppTests
//
//  Created by Ali on 13/02/22.
//

import XCTest
@testable import AdyenDemo_App

class POIRequestValidation_Test: XCTestCase {

    // MARK: - FAILURE CASES
    
    func test_POISearchRequest_WithNilQuery() {
        let request = POIRequestModel(query: nil, lat: 0.0, lon: 0.0, radius: 1.0, apiKey: "XXYYZZ")
        let validation = POIRequestModelValidation(model: request)
        
        XCTAssertFalse(validation.isValidRequest())
        
    }
    
    func test_POISearchRequest_WithNilLatAndLon() {
        let request = POIRequestModel(query: Constants.POIQuery, lat: nil, lon: nil, radius: 1.0, apiKey: "XXYYZZ")
        let validation = POIRequestModelValidation(model: request)
        
        XCTAssertFalse(validation.isValidRequest())
        
    }
    
    func test_POISearchRequest_WithNilRadius() {
        let request = POIRequestModel(query: Constants.POIQuery, lat: 0.0, lon: 0.0, radius: nil, apiKey: "XXYYZZ")
        let validation = POIRequestModelValidation(model: request)
        
        XCTAssertFalse(validation.isValidRequest())
        
    }
    
    func test_POISearchRequest_WithNilApiKey() {
        let request = POIRequestModel(query: Constants.POIQuery, lat: 0.0, lon: 0.0, radius: 30.0, apiKey: nil)
        let validation = POIRequestModelValidation(model: request)
        
        XCTAssertFalse(validation.isValidRequest())
        
    }
    
    // MARK: - Valid Request
    
    func test_POISearchRequest_WithValidParams() {
        let request = POIRequestModel(query: Constants.POIQuery, lat: 0.0, lon: 0.0, radius: 30.0, apiKey: "XYZS")
        let validation = POIRequestModelValidation(model: request)
        
        XCTAssertTrue(validation.isValidRequest())
        
    }
    
}
