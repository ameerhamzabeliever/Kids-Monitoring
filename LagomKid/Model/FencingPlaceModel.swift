//
//  FencingPlaceModel.swift
//  LagomKid
//
//  Created by Hamza-Apps on 16/05/2022.
//

import Foundation
import SwiftyJSON

struct FencingPlaceModel : Codable {
    var place_id      : Int
    var location      : String
    var latitude      : String
    var longitude     : String
    var radius        : Int
    var address       : String
    var checkin_alert : Int
    var created_at    : String
    var updated_at    : String
    
    init(json : JSON) {
        place_id      = json["place_id"]     .intValue
        location      = json["location"]     .stringValue
        latitude      = json["latitude"]     .stringValue
        longitude     = json["longitude"]    .stringValue
        radius        = json["radius"]       .intValue
        address       = json["address"]      .stringValue
        checkin_alert = json["checkin_alert"].intValue
        created_at    = json["created_at"]   .stringValue
        updated_at    = json["updated_at"]   .stringValue
    }
}
