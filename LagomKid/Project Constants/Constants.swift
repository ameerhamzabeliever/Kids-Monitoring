//
//  Constants.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 11/05/2022.
//

import Foundation
import UIKit
import Alamofire

struct Constants {
    /* MARK:- Singleton struct initilization */
    static var sharedInstance : Constants = Constants()
    
    // Authorization Heaader
    var httpHeaders           : HTTPHeaders {
        get {
            return [
                "Authorization" : UserDefaults.standard.string(forKey: userDefaults.HTTP_HEADERS) ?? "",
                "Content-Type"  : "application/json",
                "Accept"        : "application/json",
                "lang"          :UserDefaults.standard.value(forKey: "userlanguage") as? String ?? "en"
            ]
        }
    }
    var authHttpHeaders           : HTTPHeaders {
        get {
            return [
                "Authorization" : UserDefaults.standard.string(forKey: userDefaults.HTTP_HEADERS) ?? ""
            ]
        }
    }
    var httpUserToken           : HTTPHeaders {
        get {
            return [
                "token"        : Constants.sharedInstance.childUser?.api_token ?? "",
                "Content-Type" : "application/json",
                "Accept"       : "application/json",
                "lang"         :UserDefaults.standard.value(forKey: "userlanguage") as? String ?? "en"
            ]
        }
    }
    
    var childUser : ChildModel? {
        get {
            if let user = UserDefaults.standard.object(
                forKey: userDefaults.CHILD
            ) as? Data {
                
                let decoder = JSONDecoder()
                return try! decoder.decode(
                    ChildModel.self, from: user
                )
            }
            return nil
        } set {
            if let user = newValue {
                let encoder    = JSONEncoder()
                if let encoded = try? encoder.encode(user) {
                    UserDefaults.standard.set(encoded, forKey: userDefaults.CHILD)
                }
            } else {
                UserDefaults.standard.set(nil, forKey: userDefaults.CHILD)
            }
        }
    }
    
    struct Images {
        static let IMG_GIRL_BG = UIImage(named: "girl_Active")
        static let IMG_GIRL    = UIImage(named: "girl_in-Active")
        static let IMG_BOY_BG  = UIImage(named: "boy_Active")
        static let IMG_BOY     = UIImage(named: "boy_in-Active")
        static let IMG_RADIO_FILLED = UIImage(named: "radio_filled")
        static let IMG_RADIO_HOLLOW = UIImage(named: "radio_hollow")
        
        static let IMG_LOCATION = UIImage(named: "location_img")
        static let IMG_CONTACTS = UIImage(named: "contact_img")
        static let IMG_TEXTMESSAGE = UIImage(named: "textMessage_img")
        static let IMG_STARTUP     = UIImage(named: "startup_img")
        static let IMG_BACKGROUND  = UIImage(named: "background_img")
        static let IMG_STORAGE     = UIImage(named: "storage_img")
        static let IMG_INFORMATION = UIImage(named: "information_img")
        static let IMG_PERMISSION  = UIImage(named: "permission_img")
        static let IMG_USAGE       = UIImage(named: "usage_img")
        
        static let IMG_PANIC_ALERT   = UIImage(named: "panicAlertImage")
        static let IMG_PICKME_SILENT = UIImage(named: "pickmeSilentImage")
    }
    
    struct Colors  {
        static let BG_GIRL_VIEW    = UIColor(red: 244/255, green: 94/255, blue: 145/255, alpha: 0.1)
        static let GIRL_TEXT_COLOR = UIColor.init(named: "girl_text")
        static let BOY_TEXT_COLOR  = UIColor.init(named: "boy_text")
        static let GRAY_TEXT_COLOR = UIColor.init(named: "grey_text")
        static let LIGHT_GREY      = UIColor.init(named: "grey_light")
        static let BG_WHITE        = UIColor.init(named: "bg_White")
        static let LIGHT_ORANGE    = UIColor.init(named: "orange_light")
        static let DARK_PINK       = UIColor.init(named: "pink_dark")
        static let APP_ORANGE      = UIColor.init(named: "app_Orange")
    }
    
    struct Storyboard {
        // Auth
        static let QRCODE_SCAN        = "QRCodeScanController"
        static let AUTH_SPLASH        = "SplashScreenController"
        static let AUTH_NAVIGATION    = "AuthNavigationController"
        static let SET_PROFILE_SCREEN = "SetProfileController"
        static let WELCOME_SCREEN     = "WelcomeScreenController"
        static let WEB_VIEW           = "TermsAndPolicyWebViewVC"
        static let ACCESS_DATA        = "AccessDataScreenController"
        static let ACCESSIBILITY      = "AccessibilityScreenController"
        static let LOCK               = "LockScreenController"
        static let WELCOME_BACK       = "WelcomeBackScreenController"
        static let APP_BLOCKED        = "AppBlockedScreenController"
        static let DAILY_LIMIT        = "DailyLimitExceedScreenController"
        
        // Dashboard
        static let DASHBOARD_TABAR  = "DashBoardTabBar"
        static let HOME             = "HomeVC"
        static let PICKME           = "PickMeVC"
        static let SYNC_APPS        = "SyncAppsVC"
        static let PROFILE          = "ProfileVC"
        static let CHECK_PERMISSION = "CheckPermissionVC"
        static let ABOUT_APP        = "AboutAppVC"
        
        // Dialog
        static let PERMISSION_POPUP = "PermissionPopUpVC"
        static let RECONFIRM_POPUP  = "ReconfirmPopUpVC"
        
    }
    
    struct Strings {
        // storyboards
        static let STORYBOARD_AUTH      = "Auth"
        static let STORYBOARD_DASHBOARD = "Dashboard"
        static let STORYBOARD_DIALOG    = "Dialog"
        
        // strings
        static let LOCATION_TITLE     = "Location Access"
        static let CONTACTS_TITLE     = "Access to Contacts"
        static let TEXT_MESSAGE_TITLE = "Access to Text Messages"
        static let STARTUP_TITLE      = "Run at Startup"
        static let BACKGROUND_TITLE   = "Run at Background"
        static let STORAGE_TITLE      = "USB Storage"
        static let INFORMATION_TITLE  = "Device Information"
        static let PERMISSION_TITLE   = "Overlay Permission"
        static let USAGE_TITLE        = "Usage Stats & Accessibility Service"
        
        static let LOCATION_DETAILS     = "Allow us to access your location to send geo-fencing alerts and help your parents to locate you."
        static let CONTACT_DETAILS      = "Lagom would like to access call logs and contacts to give your call records and contact details to your parents."
        static let TEXT_MESSAGE_DETAILS = "Lagom would sync with your text messages to let your parents have access to your message records."
        static let STARTUP_DETAILS      = "Lagom would start automatically once you start up your device."
        static let BACKGROUND_DETAILS   = "By allowing us to run at Background, Lagom would keep working even if your device is not in use."
        static let STORAGE_DETAILS      = "Lagom would use storage memory in this device to work appropriately."
        static let INFORMATION_DETAILS  = "Lagom would need internet, wifi, network state, and phone state information so that it can sync parents to this device."
        static let PERMISSION_DETAILS   = "Lagom requires permission to lock your phone with the parent put a pause on the usage."
        static let USAGE_DETAILS        = "Lagom would need access to the app usage and other data stats to let your parents observe and set limits."
        
        //DialogPopupVCs
        static let LBL_TITlE_SOS    = "Panic Alert Sent!"
        static let LBL_DESC_SOS     = "We have notified your parents about your emergency. They must be on their way and will get in touch soon."
        static let LBL_DESC1_SOS    = "We know it can be hard. But you are strong enough to be composed and patient. Stay calm, you will be out of it soon."
        static let LBL_TITlE_PICKME = "Pick Me Alert Sent"
        static let LBL_DESC_PICKME  = "We have sent a Pick Me notification to your parents. They will be contacting you soon."
        static let LBL_DESC1_PICKME = "While your parents are on their way, wait at the same location. In case you change your location, notify by clicking the ‘Send Again’ button."
    }
    
    struct Nib {
        static let ACCESSIBILITY_CELL_NIB = "AccessibilityCustomCell"
    }
    
    struct EndPoints {
        // QR Code Scan
        static let SIGN_IN        = "/qr/signin"
        static let ACTIVATE       = "/child/ios/activate"
        static let CONTACTS       = "/device/ios/contacts"
        static let LOCATIONS      = "/device/ios/locations"
        static let FENCING_PLACES = "/device/ios/places"
        static let SOS            = "/device/ios/notifications/sos"
        static let PICKME         = "/device/ios/notifications/pickmeup"
        static let USER_PROFILE   = "/device/ios/profile"
    }
    
    struct Entities {
        static let CONTACT_LIST  = "ContactList"
        static let LAST_LOCATION = "LastLocation"
        static let FENCE_PLACE   = "FencePlace"
    }
    
    /*MARK:- User Defaults */
    struct userDefaults {
        static let HTTP_HEADERS = "httpHeaders"
        static let CHILD        = "child"
    }
}
