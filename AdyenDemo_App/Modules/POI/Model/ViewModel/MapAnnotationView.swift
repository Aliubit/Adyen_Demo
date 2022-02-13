//
//  MapAnnotationView.swift
//  AdyenDemo_App
//
//  Created by Ali on 12/02/22.
//

import Foundation
import MapKit

// MARK: - ViewModel to view Map Annotations and list view data

class MapAnnotationView: NSObject, MKAnnotation {
    let title: String?
    let phoneNumber: String?
    let address: String?
    let coordinate: CLLocationCoordinate2D
    var distance = 0.0
    
    init(
        title: String?,
        phoneNumber: String?,
        address: String?,
        coordinate: CLLocationCoordinate2D,
        distance : CLLocationDistance? = nil
    ) {
        self.title = title
        self.phoneNumber = phoneNumber
        self.address = address
        self.coordinate = coordinate
        self.distance = distance ?? 0.0
        super.init()
    }
    
    var subtitle: String? {
        return phoneNumber
    }
}
