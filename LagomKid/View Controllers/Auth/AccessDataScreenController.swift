//
//  AccessDataScreenController.swift
//  LagomKid
//
//  Created by YumyApps on 07/04/2022.
//

import UIKit

class AccessDataScreenController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var accessDataLabel: UILabel!
    @IBOutlet weak var LagomDetailsLabel: UILabel!
    @IBOutlet weak var lagomImageView: UIImageView!
    
    @IBOutlet weak var backButtonOutlet: UIButton! {
        didSet {
            backButtonOutlet.layer.cornerRadius = 16.0
            backButtonOutlet.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nextButtonOutlet: UIButton! {
        didSet {
            nextButtonOutlet.layer.cornerRadius = 16.0
            nextButtonOutlet.layer.masksToBounds = true
        }
    }
    
    //MARK: - Variables
   
    
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    //MARK: - IBActions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.popBackController()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.goToTheAccessibilityScreen()
    }
    
    //MARK: - Helper Functions
    private func popBackController() {
         if #available(iOS 13.0, *) {
             self.navigationController?.popViewController(animated: true)
         }else{
            self.navigationController?.popViewController(animated: true)
         }
     }
    
    private func goToTheAccessibilityScreen() {
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_AUTH, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.ACCESSIBILITY) as! AccessibilityScreenController
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
