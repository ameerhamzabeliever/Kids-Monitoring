//
//  ChildProfile.swift
//  LagomKid
//
//  Created by Hamza-Apps on 13/05/2022.
//

import Foundation
import SwiftyJSON

struct UserProfile : Codable {
    let subscription_expiry : String
    let package_id          : Int
    let child               : ProfileModel
    
    init(json : JSON) {
        subscription_expiry = json["subscription_expiry"].stringValue
        package_id          = json["package_id"].intValue
        child               = ProfileModel(json: JSON(rawValue: json["child"]) ?? "")
    }
}

struct ProfileModel : Codable {
    let child_id        : Int
    let name            : String
    let birthday        : String
    let gender          : String
    let relationship    : String
    let email           : String
    let phone           : String
    let plateform_id    : Int
    let device          : String
    let package_id      : Int
    let package         : String
    let duration        : String
    let expiry_date     : String
    let remaining_days  : String
    let cover_img_src   : String
    let profile_img_src : String
    let color           : String
    let phonelock_status : Int
    let active          : Int
    let deleted         : Int
    let deleted_by      : String
    let super_user_id   : Int
    let activation_code : String
    let push_token      : String
    let child_enrolled  : Int
    let child_mdm_hash  : String
    let is_production_build : Int
    let version_number  : String
    let version_code    : String
    let subscription_id : String
    let school_id       : Int
    let campus_id       : Int
    let class_id        : Int
    let reseller_id     : Int
    let time_zone       : String
    let is_forget_me    : Int
    let api_token       : String
    let activation_date : String
    let created_at      : String
    let updated_at      : String
    
    init(json : JSON) {
        child_id            = json["child_id"].intValue
        name                = json["name"].stringValue
        birthday            = json["birthday"].stringValue
        gender              = json["gender"].stringValue
        relationship        = json["relationship"]  .stringValue
        email               = json["email"]  .stringValue
        phone               = json["phone"].stringValue
        plateform_id        = json["plateform_id"].intValue
        device              = json["device"].stringValue
        package_id          = json["package_id"].intValue
        package             = json["package"]  .stringValue
        duration            = json["duration"]  .stringValue
        expiry_date         = json["expiry_date"].stringValue
        remaining_days      = json["remaining_days"].stringValue
        cover_img_src       = json["cover_img_src"].stringValue
        profile_img_src     = json["profile_img_src"].stringValue
        color               = json["color"]  .stringValue
        phonelock_status    = json["phonelock_status"]  .intValue
        active              = json["active"].intValue
        deleted             = json["deleted"].intValue
        deleted_by          = json["deleted_by"].stringValue
        super_user_id       = json["super_user_id"].intValue
        activation_code     = json["activation_code"]  .stringValue
        push_token          = json["push_token"]  .stringValue
        child_enrolled      = json["child_enrolled"].intValue
        child_mdm_hash      = json["child_mdm_hash"].stringValue
        is_production_build = json["is_production_build"].intValue
        version_number      = json["version_number"].stringValue
        version_code        = json["version_code"].stringValue
        subscription_id     = json["subscription_id"]  .stringValue
        school_id           = json["school_id"]  .intValue
        campus_id           = json["campus_id"].intValue
        class_id            = json["class_id"].intValue
        reseller_id         = json["reseller_id"].intValue
        time_zone           = json["time_zone"].stringValue
        is_forget_me        = json["is_forget_me"]  .intValue
        api_token           = json["api_token"].stringValue
        activation_date     = json["activation_date"].stringValue
        created_at          = json["created_at"].stringValue
        updated_at          = json["updated_at"].stringValue
    }
}
