//
//  ProfileVC.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 07/04/2022.
//

import UIKit
import SwiftyJSON

class ProfileVC: UIViewController {
    
    /* MARK: - Outlets and Properties */
    @IBOutlet weak var lblTitleProfile     : UILabel!
    @IBOutlet weak var lblUserName         : UILabel!
    @IBOutlet weak var lblDevice           : UILabel!
    @IBOutlet weak var lblHeadName         : UILabel!
    @IBOutlet weak var lblHeadGender       : UILabel!
    @IBOutlet weak var lblHeadRelation     : UILabel!
    @IBOutlet weak var lblCheckPermission  : UILabel!
    @IBOutlet weak var lblAboutApp         : UILabel!
    @IBOutlet weak var imgUser             : UIImageView!
    @IBOutlet weak var tfName              : UITextField!
    @IBOutlet weak var tfGender            : UITextField!
    @IBOutlet weak var tfRelation          : UITextField!
    @IBOutlet weak var viewBackProfileInfo : UIView!
    @IBOutlet weak var viewBackCheckPerm   : UIView!
    @IBOutlet weak var viewBackAboutApp    : UIView!
    @IBOutlet weak var viewBackUserInfo    : UIView!
    @IBOutlet weak var btnCheckPerm        : UIButton!
    @IBOutlet weak var btnAboutApp         : UIButton!
    
    var userProfile : UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setData()
        getUserProfile()
    }
}

/* MARK: - Actions */
extension ProfileVC{
    @IBAction func didTapCheckPermission(_ sender : UIButton){
        print("check permission tapped")
        goToCheckPermission()
    }
    @IBAction func didTapAboutApp(_ sender : UIButton){
        print("about app tapped")
        goToAboutApp()
    }
}

/* MARK: - Api Methods */
extension ProfileVC{
    func getUserProfile(){
        self.loader(isAnimate: true)
        NetworkManager.sharedInstance.userProfile{
            (response) in
            self.loader(isAnimate: false)
            switch response.result{
            case .success(_):
                do {
                    let apiData = try JSON(data: response.data!)
                    Helper.debugLogs(data: apiData, title: "Api Response")
                    let message = apiData["message"]
                    let status = apiData["status"]
                    if status == 200{
                        self.userProfile = UserProfile(json: apiData)
                        print(self.userProfile)
                        self.lblUserName.text = self.userProfile?.child.name
                        self.lblDevice.text = self.userProfile?.child.device
                        self.tfName.text      = self.userProfile?.child.name
                        self.tfGender.text    = self.userProfile?.child.gender
                        self.tfRelation.text  = self.userProfile?.child.relationship
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
extension ProfileVC{
    func setupLayouts(){
        viewBackProfileInfo.layer.cornerRadius = 30.0
        imgUser.layer.cornerRadius = imgUser.frame.size.height / 2
        viewBackUserInfo.layer.cornerRadius = 30.0
        viewBackCheckPerm.layer.cornerRadius = 30.0
        viewBackAboutApp.layer.cornerRadius = 30.0
        Helper.addShadow(viewBackProfileInfo)
        Helper.addShadow(viewBackCheckPerm)
        Helper.addShadow(viewBackAboutApp)
    }
    func setData(){
        tfName.isUserInteractionEnabled = false
        tfGender.isUserInteractionEnabled = false
        tfRelation.isUserInteractionEnabled = false
    }
    func goToCheckPermission(){
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_DASHBOARD, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.CHECK_PERMISSION) as! CheckPermissionVC
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func goToAboutApp(){
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_DASHBOARD, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.ABOUT_APP) as! AboutAppVC
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
