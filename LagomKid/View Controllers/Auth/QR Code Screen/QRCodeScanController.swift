//
//  QRCodeScanController.swift
//  LagomKid
//
//  Created by YumyApps on 30/03/2022.
//

import UIKit
import SwiftyJSON

class QRCodeScanController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var qrCodeView: QRCodeCustomView! {
        didSet {
            qrCodeView.delegate = self
        }
    }
    
    @IBOutlet weak var scanButtonOutlet: UIButton! {
        didSet {
            self.scanButtonOutlet.layer.cornerRadius = 9.0
            self.scanButtonOutlet.layer.masksToBounds = true
        }
    }
    
    
    @IBOutlet weak var scanQrCodeTextLabel: UILabel!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    
    //MARK: - Varibales
    private var qrCodeString : String?
    
    
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !qrCodeView.isRunning {
            self.qrCodeView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !qrCodeView.isRunning {
            qrCodeView.stopScanning()
        }
    }
    
    //MARK: - IBActions
    @IBAction func scanButtonPressed(_ sender: Any) {
    }
}


//MARK: - QRCodeCustomView Delegates
extension  QRCodeScanController : QRScannerViewDelegate {
    
    func qrCodeScanDidFail() {
        
    }
    
    func qrCodeScanSucceededWithCode(_ codeString: String?) {
        self.qrCodeString = codeString
        print("QR code String is, ",self.qrCodeString ?? "")
        qrSignIn(qrString: qrCodeString ?? "")
    }
    
    func qrCodeScanDidEnd() {
        
    }
}

/* MARK: - Api Methods */
extension QRCodeScanController{
    
    func qrSignIn(qrString : String){
        self.loader(isAnimate: true)
        var parameters : [String: Any] = [:]
        parameters["qr_code"] = qrString
        NetworkManager.sharedInstance.qrSignIn(param: parameters){
            (response) in
            self.loader(isAnimate: false)
            switch response.result{
            case .success(_):
                do {
                    let apiData = try JSON(data: response.data!)
                    Helper.debugLogs(data: apiData, title: "Api Response")
                    let status = apiData["status"]
                    let message = apiData["message"]
                    let dataObj = apiData["data"]
                    if status == true{
                        let token   = "Bearer \(dataObj["token"].stringValue)"
                        let userId  = dataObj["user_id"]
                        print("token is: \(token)")
                        UserDefaults.standard.set(token, forKey: Constants.userDefaults.HTTP_HEADERS)
                        self.navigateToSetProfile()
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
    func navigateToSetProfile(){
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_AUTH, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.SET_PROFILE_SCREEN) as! SetProfileController
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
