//
//  DashBoardTabBar.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 04/04/2022.
//

import UIKit

class DashBoardTabBar: UITabBarController, UITabBarControllerDelegate {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedIndex = tabBar.items?.firstIndex(of: item) ?? 1000
        print("Selected item \(String(describing: selectedIndex))")
        if selectedIndex == 1{
            if Constants.sharedInstance.childUser?.package == "free" || Constants.sharedInstance.childUser?.package == "FREE"{
                goToPermissionPopUp()
            }
            else{
                
            }
        }
        if selectedIndex == 2{
            goToReconfirmPopUp()
        }
    }
}
 
/* MARK: - Extensions */
extension DashBoardTabBar{
    func goToPermissionPopUp(){
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_DIALOG, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.PERMISSION_POPUP) as! PermissionPopUpVC
        vc.onDismiss =  {
            self.selectedIndex = 0
            print("come back again")
        }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
    func goToReconfirmPopUp(){
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_DIALOG, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.RECONFIRM_POPUP) as! ReconfirmPopUpVC
        vc.isSos = true
        vc.onDismiss =  {
            self.selectedIndex = 0
            print("come back again")
        }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
