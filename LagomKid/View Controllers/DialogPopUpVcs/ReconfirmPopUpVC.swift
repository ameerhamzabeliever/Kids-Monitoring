//
//  ReconfirmPopUpVC.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 07/04/2022.
//

import UIKit
import CoreLocation
import SwiftyJSON

class ReconfirmPopUpVC: UIViewController {
    /* MARK: - Outlets and Properties */
    @IBOutlet weak var viewContentBack : UIView!
    @IBOutlet weak var imgContentView  : UIImageView!
    @IBOutlet weak var lblTitle        : UILabel!
    @IBOutlet weak var lblTitleDesc    : UILabel!
    @IBOutlet weak var lblTitleDesc1   : UILabel!
    @IBOutlet weak var btnSendAgain    : UIButton!
    @IBOutlet weak var btnCancel       : UIButton!
    
    var isSos = false
    var onDismiss: (()->Void)?
    
    var locManager = CLLocationManager()
    var currentLat : Double?
    var currentLong : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setupData()
    }
    override func viewWillAppear(_ animated: Bool) {
        if isSos{
            getCurrentLatLong()
        }
    }
}

/* MARK: - Actions */
extension ReconfirmPopUpVC{
    @IBAction func didTapSendAgain(_ sender: UIButton){
        print("send again tapped")
        if isSos{
            getCurrentLatLong()
        }
    }
    @IBAction func didTapCancel(_ sender: UIButton){
        print("cancel tapped")
        self.onDismiss!()
        self.dismiss(animated: false, completion: nil)
    }
}
/* MARK: - Api Methods */
extension ReconfirmPopUpVC{
    func sendSos(params : [String: Any]){
        self.loader(isAnimate: true)
        NetworkManager.sharedInstance.sos(param: params){
            (response) in
            self.loader(isAnimate: false)
            switch response.result{
            case .success(_):
                do {
                    let apiData = try JSON(data: response.data!)
                    Helper.debugLogs(data: apiData, title: "Api Response")
                    let status = apiData["status"]
                    let message = apiData["message"]
                    if status == 200{
                        self.ShowErrorAlert(message: message.stringValue)
                    }
                    else{
                        self.ShowErrorAlert(message: message.stringValue)
                    }
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

/* MARK: - Extensions */
extension ReconfirmPopUpVC{
    func setupLayouts(){
        viewContentBack.layer.cornerRadius = 30.0
        btnSendAgain.layer.cornerRadius = 15.0
        btnCancel.layer.cornerRadius = 15.0
    }
    func setupData(){
        if isSos{
            imgContentView.image = Constants.Images.IMG_PANIC_ALERT
            lblTitle.text = Constants.Strings.LBL_TITlE_SOS
            lblTitleDesc.text = Constants.Strings.LBL_DESC_SOS
            lblTitleDesc1.text = Constants.Strings.LBL_DESC1_SOS
        }
        else{
            imgContentView.image = Constants.Images.IMG_PICKME_SILENT
            lblTitle.text = Constants.Strings.LBL_TITlE_PICKME
            lblTitleDesc.text = Constants.Strings.LBL_DESC_PICKME
            lblTitleDesc1.text = Constants.Strings.LBL_DESC1_PICKME
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
            param["push_type"] = "sos"
            param["pin"] = ""
            sendSos(params: param)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == self.view {
            print("started")
            self.onDismiss!()
            self.dismiss(animated: false, completion: nil)
        }
    }
}
