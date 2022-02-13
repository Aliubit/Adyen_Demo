//
//  Constants.swift
//  AdyenDemo_App
//
//  Created by Ali on 11/02/22.
//

import Foundation

// MARK: - Constants

struct Constants {
    static var tomTomApiKey = "wwJ4IJ50sw2rDPm6gfeeYWiR6DANQ561"
    static var POIQuery = "Restaurant"
    static var defaultFont = "HelveticaNeue"
    static var MapView = "Map"
    static var ListView = "List"
    static var radius = 500.0
}

struct Messages {
    static var defaultTitle = "Alert"
    static var enableLocationMessage = "Please Enable Location Services in order to use app"
    static var enableLocationOk = "OK"
    
    static var serviceResponseFailedMessage = "Failed to get response from service"
    static var invalidRequest = "Invalid Request is being sent"
}

// MARK: - Enums

enum CurrentPOIView : Int {
    case Map = 0
    case List = 1
}

enum CellsIdentifier : String{
    case POITableViewCell = "POITableViewCell"
}
