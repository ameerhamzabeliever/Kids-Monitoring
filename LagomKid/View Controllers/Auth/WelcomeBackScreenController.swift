//
//  WelcomeBackScreenController.swift
//  LagomKid
//
//  Created by Mian Usama on 12/04/2022.
//

import UIKit

class WelcomeBackScreenController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var welcomeBackImageView: UIImageView!
    
    @IBOutlet weak var welcomeBackLabel: UILabel!
    @IBOutlet weak var useDeviceLabel: UILabel!
    
    
    @IBOutlet weak var letsGoButtonOutlet: UIButton! {
        didSet {
            letsGoButtonOutlet.layer.cornerRadius = 16.0
            letsGoButtonOutlet.layer.masksToBounds = true
        }
    }
    
    //MARK: - Variables
    
    
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: - IBActions
    
    @IBAction func letsGoButtonPressed(_ sender: Any) {
        goToDashboard()
    }
}

/* MARK: - Extensions */
extension WelcomeBackScreenController{
    func goToDashboard(){
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_DASHBOARD, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.DASHBOARD_TABAR) as! DashBoardTabBar
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
