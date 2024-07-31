//
//  PickMeVC.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 06/04/2022.
//

import UIKit
import CoreLocation
import SwiftyJSON

class PickMeVC: UIViewController {
    
    /* MARK: - Outlets and Properties */
    @IBOutlet weak var btnTapToActivate        : UIButton!
    @IBOutlet weak var viewLoadingAnimation    : UIImageView!
    @IBOutlet weak var viewBgLocation          : UIView!
    @IBOutlet weak var lblTitlePickMe          : UILabel!
    @IBOutlet weak var lblTapToActive          : UILabel!
    @IBOutlet weak var lblTitleYourLocation    : UILabel!
    @IBOutlet weak var lblCurrentLocation      : UILabel!
    @IBOutlet weak var lblAccuracytLocation    : UILabel!
    
    var isAnimated = false
    
    var locManager = CLLocationManager()
    var currentLat : Double?
    var currentLong : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if Constants.sharedInstance.childUser?.package == "free" || Constants.sharedInstance.childUser?.package == "FREE"{
            print("Free user that's why pickme don't apply")
        }
        else{
            getCurrentLatLong()
        }
    }
}

/* MARK: - Actions */
extension PickMeVC{
    @IBAction func didTapActivate(_ sender : UIButton){
        print("Tap to activate have been tapped")
        isAnimated = !isAnimated
        self.rotateView(targetView: viewLoadingAnimation)
    }
}

/* MARK: - Extensions */
extension PickMeVC{
    func setupLayouts(){
        viewBgLocation.layer.cornerRadius = 25.0
        Helper.addShadow(viewBgLocation)
    }
    private func rotateView(targetView: UIImageView, duration: Double = 0.5) {
        UIImageView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(M_PI))
        }) { finished in
            if self.isAnimated{
                self.rotateView(targetView: targetView, duration: duration)
            }
            else{
                self.viewLoadingAnimation.stopAnimating()
            }
        }
    }
    func getCurrentLatLong(){
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        if
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager.location
            currentLat = currentLocation.coordinate.latitude
            currentLong = currentLocation.coordinate.longitude
            print(currentLat, currentLong)
            let latLongaddress = Helper.getAddressFromCoordinates(withLatitude: currentLat ?? 0.0, withLongitude: currentLong ?? 0.0)
            print(latLongaddress)
            let currDateAndTime = Helper.getDateAndTime()
            print(currDateAndTime)
            var param : [String: Any] = [:]
            param["address"] =  latLongaddress
            param["latitude"] = "\(currentLat ?? 0.0)"
            param["longitude"] = "\(currentLong ?? 0.0)"
            param["accuracy"] = "15.00 m"
            param["push_time"] = currDateAndTime
            param["push_type"] = "pickup"
            param["pin"] = ""
            pickMe(params: param)
        }
    }
}

/* MARK: - Api Methods */
extension PickMeVC{
    func pickMe(params : [String: Any]){
        self.loader(isAnimate: true)
        NetworkManager.sharedInstance.pickme(param: params){
            (response) in
            self.loader(isAnimate: false)
            switch response.result{
            case .success(_):
                do {
                    let apiData = try JSON(data: response.data!)
                    Helper.debugLogs(data: apiData, title: "Api Response")
                }
                catch {
                    self.showToast(response.error?.localizedDescription ?? "Something went wrong.")
                }
            case .failure(_):
                self.ShowErrorAlert(message: "Something went wrong")
            }
        }
    }
}
