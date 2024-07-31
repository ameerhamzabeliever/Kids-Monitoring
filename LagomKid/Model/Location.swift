//
//  Location.swift
//  LagomKid
//
//  Created by Hamza-Apps on 13/05/2022.
//

import Foundation
import SwiftyJSON

struct LocationModel : Codable {
    let child_id       : Int
    let location       : String
    let latitude       : String
    let longitude      : String
    let time_in        : String
    let deleted        : Int
    let updated_at     : String
    let created_at     : String
    let geolocation_id : Int
    
    init(json : JSON) {
        child_id   = json["child_id"].intValue
        location   = json["location"].stringValue
        latitude   = json["latitude"].stringValue
        longitude  = json["longitude"].stringValue
        time_in    = json["time_in"]  .stringValue
        deleted    = json["deleted"]  .intValue
        updated_at = json["updated_at"].stringValue
        created_at = json["created_at"].stringValue
        geolocation_id = json["geolocation_id"].intValue
    }
}
