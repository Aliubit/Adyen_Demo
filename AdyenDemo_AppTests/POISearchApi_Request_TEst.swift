//
//  POISearchApi_Request_TEst.swift
//  AdyenDemo_AppTests
//
//  Created by Ali on 13/02/22.
//

import XCTest
@testable import AdyenDemo_App

class POISearchApi_Request_TEst: XCTestCase {

    func test_GetPOI_ValidRequest_Retuns_ResponseModel() {
        
        let request = POIRequestModel(query: "Restaurant", lat: LocationManager.shared.location.coordinate.latitude, lon: LocationManager.shared.location.coordinate.longitude, radius: Constants.radius, apiKey: Constants.tomTomApiKey)
        
        let expectations = self.expectation(description: "ValidRequest_Retuns_ResponseModel")
        
        POIRestHandler.getPOI(requestModel: request, completion: {(response,message) in
            XCTAssertNotNil(response)
            XCTAssertNil(message)
            expectations.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func test_GetPOI_InvalidRequestQuery_Retuns_Nil() {
        
        let request = POIRequestModel(query: "HAKUNAMATATAASDASDASDAS", lat: -1.00, lon: -12.0, radius: -1.0, apiKey: Constants.tomTomApiKey + "ASDASDASD")
        
        let expectations = self.expectation(description: "InvalidRequestQuery_Retuns_Nil")

        POIRestHandler.getPOI(requestModel: request, completion: {(response,message) in
            XCTAssertNil(response)
            XCTAssertNotNil(message)
            XCTAssertEqual(message, Messages.serviceResponseFailedMessage)
            expectations.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }

}
