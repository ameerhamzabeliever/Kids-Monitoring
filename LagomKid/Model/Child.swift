//
//  Child.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 14/04/2022.
//

import Foundation
import SwiftyJSON

struct ChildModel : Codable {
    let super_user_id      : Int
    let subscription_id    : String
    let color          : String
    let expiry_date    : String
    let activation_date: String
    let created_at     : String
    let package        : String
    let device         : String
    let name           : String
    let package_id     : Int
    let child_id       : Int
    let active         : Int
    let api_token      : String
    let version_number : String
    let updated_at     : String
    let plateform_id   : String
    let time_zone      : String
    let relationship   : String
    let version_code   : String
    let push_token     : String
    let gender         : String
    
    init(json : JSON) {
        super_user_id   = json["super_user_id"]  .intValue
        subscription_id = json["subscription_id"].stringValue
        color           = json["color"]       .stringValue
        expiry_date     = json["expiry_date"] .stringValue
        activation_date = json["activation_date"]  .stringValue
        created_at      = json["created_at"]          .stringValue
        package         = json["package"]          .stringValue
        device          = json["device"]            .stringValue
        name            = json["name"].stringValue
        package_id      = json["package_id"].intValue
        child_id        = json["child_id"].intValue
        active          = json["active"].intValue
        api_token       = json["api_token"].stringValue
        version_number  = json["version_number"].stringValue
        updated_at      = json["updated_at"].stringValue
        plateform_id    = json["plateform_id"].stringValue
        time_zone       = json["time_zone"].stringValue
        relationship    = json["relationship"].stringValue
        version_code    = json["version_code"].stringValue
        push_token      = json["push_token"].stringValue
        gender          = json["gender"].stringValue
    }
}
