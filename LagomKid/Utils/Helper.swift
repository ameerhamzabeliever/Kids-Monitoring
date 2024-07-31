//
//  UtilityConstants.swift
//  LagomKid
//
//  Created by YumyApps on 04/04/2022.
//

import Foundation
import UIKit
import CoreLocation

class Helper {
    
    static func showAlert(view:UIViewController,title:String,message:String) {
        let alertController = UIAlertController(title: "Error.!", message: message, preferredStyle: .alert)
    }
    
    static func addShadow(_ view : UIView){
        view.layer.shadowOffset = CGSize(width:0, height:0)
        view.layer.shadowRadius = 10
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
    }
    
    static func debugLogs(data: Any, title: String = "Log") {
        print("============= DEBUG LOGS START =================")
        print("\(title): \(data)")
        print("=============  DEBUG LOGS END  =================")
        print("\n \n")
    }

}

extension Helper{
    static func getAddressFromCoordinates(withLatitude: Double, withLongitude: Double) -> String {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = withLatitude
        let lon: Double = withLongitude
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        var addressString : String = ""
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                return
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                print(pm.country)
                print(pm.locality)
                print(pm.subLocality)
                print(pm.thoroughfare)
                print(pm.postalCode)
                print(pm.subThoroughfare)
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                
                
                print(addressString)
            }
        })
        return addressString
    }
    static func getDateAndTime() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = formatter.string(from: date)
        print(result)
        return result
    }
    static func getDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        print(result)
        return result
    }
}
