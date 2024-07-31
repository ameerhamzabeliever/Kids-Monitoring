//
//  LockScreenController.swift
//  LagomKid
//
//  Created by YumyApps on 08/04/2022.
//

import UIKit

class LockScreenController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var timeToBedImageView: UIImageView!
    @IBOutlet weak var timeToBedLabel: UILabel!
    @IBOutlet weak var takeRestLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var pickMeUpButtonOutlet: UIButton!
    @IBOutlet weak var sosAlertButtonOutlet: UIButton!
    
    @IBOutlet weak var ulockButtonOutlet: UIButton! {
        didSet {
            ulockButtonOutlet.layer.cornerRadius = 16.0
            ulockButtonOutlet.layer.masksToBounds = true
        }
    }
    
    
    //MARK: - Variables
    
    
    //MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IBActions

    @IBAction func pickMeUpButtonPresssed(_ sender: Any) {
        
    }
    
    
    @IBAction func sosAlertButtonPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
        goToTheWelcomeBackScreen()
    }
    
    
    //MARK: - Helper Functions
    private func goToTheWelcomeBackScreen() {
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_AUTH, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.WELCOME_BACK) as! WelcomeBackScreenController
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
