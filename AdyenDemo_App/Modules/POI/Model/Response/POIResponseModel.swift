//
//  POIResponseModel.swift
//  AdyenDemo_App
//
//  Created by Ali on 12/02/22.
//

import Foundation


// MARK: - POIResponseModel
struct POIResponseModel: Codable {
    let summary: Summary?
    let results: [Result]?
    
    enum CodingKeys : String, CodingKey {
        case summary = "summary"
        case results = "results"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(summary, forKey: .summary)
        try container.encode(results, forKey: .results)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent(Summary.self, forKey: .summary)
        results = try values.decodeIfPresent([Result].self, forKey: .results)
    }
}

// MARK: - Summary
struct Summary: Codable {
    let query, queryType: String
    let queryTime, numResults, offset, totalResults: Int
    let fuzzyLevel: Int
    let geoBias: GeoBias
}

// MARK: - Result
struct Result: Codable {
    let type: String?
    let id: String?
    let score, dist: Double?
    let info: String?
    let poi: Poi?
    let address: Address?
    let position: GeoBias?
    let viewport: Viewport?
    let entryPoints: [EntryPoint]?
    let dataSources: DataSources?
}

// MARK: - Poi
struct Poi: Codable {
    let name: String
    let phone: String?
    let categorySet: [CategorySet]?
    let categories: [String]?
    let classifications: [Classification]
    let url: String?
    let brands: [Brand]?
}

// MARK: - Address
struct Address: Codable {
    let streetNumber, streetName: String?
    let municipality, countrySecondarySubdivision, municipalitySubdivision, countrySubdivision: String?
    let postalCode: String?
    let countryCode: String?
    let country: String?
    let countryCodeISO3: String?
    let freeformAddress: String?
    let localName: String?
}

// MARK: - DataSources
struct DataSources: Codable {
    let poiDetails: [PoiDetail]?
}

// MARK: - PoiDetail
struct PoiDetail: Codable {
    let id, sourceName: String?
}

// MARK: - EntryPoint
struct EntryPoint: Codable {
    let type: String?
    let position: GeoBias?
}

// MARK: - GeoBias
struct GeoBias: Codable {
    let lat, lon: Double?
}

// MARK: - CategorySet
struct CategorySet: Codable {
    let id: Int?
}

// MARK: - Classification
struct Classification: Codable {
    let code: String?
    let names: [Name]?
}

// MARK: - Brand
struct Brand: Codable {
    let name: String?
}

// MARK: - Viewport
struct Viewport: Codable {
    let topLeftPoint, btmRightPoint: GeoBias?
}

// MARK: - Name
struct Name: Codable {
    let nameLocale: String?
    let name: String?
}

