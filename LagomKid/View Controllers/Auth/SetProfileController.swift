//
//  SetProfileController.swift
//  LagomKid
//
//  Created by YumyApps on 04/04/2022.
//

import UIKit
import SwiftyJSON

class SetProfileController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var setProfileLabel: UILabel!
    @IBOutlet weak var childDetailsLabel: UILabel!
    @IBOutlet weak var selectGenderLabel: UILabel!
    @IBOutlet weak var girlLabel: UILabel!
    @IBOutlet weak var boyLabel: UILabel!
    
    @IBOutlet weak var enterNameTextField: UITextField!
    
    @IBOutlet weak var boyImageView: UIImageView!
    @IBOutlet weak var girlImageView: UIImageView!
    
    @IBOutlet weak var girlViewContainer: UIView!
    @IBOutlet weak var boyViewContainer: UIView!
    
    
    @IBOutlet weak var continueButtonOutlet: UIButton! {
        didSet {
            continueButtonOutlet.layer.cornerRadius = 9.0
            continueButtonOutlet.layer.masksToBounds = true
        }
    }
    
    
    //MARK: - Variables
    var isSeletedValue : String = ""
    var childName      : String = ""
    
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpTapGestureForViews()
    }
    
    //MARK: - IBActions
    @IBAction func continueButtonPressed(_ sender: Any) {
        if validateTextField() {
            activateChild()
        }
    }
    
    @objc func girlClickView() {
        girlIsSelected()
        print(self.isSeletedValue)
    }
    
    @objc func boyClickView() {
        boyIsSelected()
        print(self.isSeletedValue)
    }
    
    private func setUpTapGestureForViews() {
        let tapGestureForGirl = UITapGestureRecognizer(target: self, action: #selector(girlClickView))
        self.girlViewContainer.isUserInteractionEnabled = true
        self.girlViewContainer.addGestureRecognizer(tapGestureForGirl)
        
        
        let tapGestureForBoy = UITapGestureRecognizer(target: self, action: #selector(boyClickView))
        self.boyViewContainer.isUserInteractionEnabled = true
        self.boyViewContainer.addGestureRecognizer(tapGestureForBoy)
        
    }
    
    
    private func boyIsSelected() {
        self.boyLabel.textColor = Constants.Colors.BOY_TEXT_COLOR
        self.boyImageView.image = Constants.Images.IMG_BOY_BG
        
        self.girlLabel.textColor = Constants.Colors.GRAY_TEXT_COLOR
        self.girlImageView.image = Constants.Images.IMG_GIRL
        
        self.isSeletedValue = "male"
    }
    
    private func girlIsSelected() {
        self.girlImageView.image = Constants.Images.IMG_GIRL_BG
        self.girlLabel.textColor = Constants.Colors.GIRL_TEXT_COLOR
        
        self.boyLabel.textColor = Constants.Colors.GRAY_TEXT_COLOR
        self.boyImageView.image = Constants.Images.IMG_BOY
        self.isSeletedValue = "female"
    }
    
    
    private func validateTextField() -> Bool {
        
        childName = self.enterNameTextField.text ?? ""
        
        if childName.isEmpty == true {
            self.showToast("Please fill out your name in field")
            return false
        } else if self.isSeletedValue  == "" {
            self.showToast("Please select your child's gender")
            return false
        }
        
        return true
        
    }
    
}

/* MARK: - Api Methods */
extension SetProfileController{
    func activateChild(){
        self.loader(isAnimate: true)
        let currentTimeZone = NSTimeZone.local as NSTimeZone
        var params : [String : Any] = [:]
        params["name"] = childName
        params["time_zone"] = currentTimeZone.name
        params["gender"] = isSeletedValue
        params["version_number"] = childName
        params["version_code"] = childName
        params["push_token"] = childName
        NetworkManager.sharedInstance.activateChild(param: params){
            (response) in
            self.loader(isAnimate: false)
            switch response.result{
            case .success(_):
                do {
                    let apiData = try JSON(data: response.data!)
                    Helper.debugLogs(data: apiData, title: "Api Response")
                    let status = apiData["status"]
                    let message = apiData["message"]
                    let dataObj = apiData["child"]
                    if status == 200{
                        Constants.sharedInstance.childUser = ChildModel(json: dataObj)
                        print(Constants.sharedInstance.childUser?.api_token)
                        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_AUTH, bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.WELCOME_SCREEN) as! WelcomeScreenController
                        vc.navigationController?.isNavigationBarHidden = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else{
                        self.ShowErrorAlert(message: message.stringValue)
                    }
                }
                catch{
                    self.showToast(response.error?.localizedDescription ?? "Something went wrong.")
                }
            case .failure(_):
                self.ShowErrorAlert(message: "Something went wrong")
            }
        }
    }
}
