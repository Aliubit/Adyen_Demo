//
//  POIRequestModel.swift
//  AdyenDemo_App
//
//  Created by Ali on 13/02/22.
//

import Foundation

struct POIRequestModel {
    var query : String?
    var lat : Double?
    var lon : Double?
    var radius : Double?
    var apiKey : String?
}

struct POIRequestModelValidation {
    var model : POIRequestModel
    func isValidRequest() -> Bool {
        guard model.query != nil, model.lat != nil, model.lon != nil, model.radius != nil, model.apiKey != nil else {
            return false
        }
        return true
    }
}
