//
//  POIRestHandler.swift
//  AdyenDemo_App
//
//  Created by Ali on 11/02/22.
//

import Foundation
import Alamofire

// MARK: - Endpoints
// All the endpoints to be used in this module will be here
enum Endpoints : String {
    case getPOI = "https://api.tomtom.com/search/2/poiSearch/{QUERY}.json?key={API_KEY}&lat={LAT}&lon={LON}&radius={RADIUS}"
}

// MARK: - POI Rest Services Wrapper

class POIRestHandler {
    
    // Get call for Points of interest
    static func getPOI(requestModel : POIRequestModel, completion : @escaping (POIResponseModel? ,String?) -> Void) {
        
        let validationRequest = POIRequestModelValidation(model: requestModel)
        if validationRequest.isValidRequest() {
            let urlString = Endpoints.getPOI.rawValue
            let url = urlString.replacingOccurrences(of: "{QUERY}", with: requestModel.query!).replacingOccurrences(of: "{API_KEY}", with: requestModel.apiKey!).replacingOccurrences(of: "{LAT}", with: "\(requestModel.lat!)").replacingOccurrences(of: "{LON}", with: "\(requestModel.lon!)").replacingOccurrences(of: "{RADIUS}", with: "\(Int(requestModel.radius!))")
            AF.request(url,method: .get).response { response in
                guard let data = response.data else {
                    completion(nil,Messages.serviceResponseFailedMessage)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(POIResponseModel.self, from: data)
                    debugPrint(response)
                    completion(response,nil)
                } catch let error {
                    print(error)
                    completion(nil,Messages.serviceResponseFailedMessage)
                }
            }
        }
        else {
            // REQUEST IS INVALID
            completion(nil,Messages.invalidRequest)
        }
        
        
    }
}
