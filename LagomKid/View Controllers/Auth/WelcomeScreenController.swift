//
//  WelcomeScreenController.swift
//  LagomKid
//
//  Created by YumyApps on 05/04/2022.
//

import UIKit

class WelcomeScreenController: UIViewController, UITextViewDelegate {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var welcomeImageView: UIImageView!
    @IBOutlet weak var radioButtonOutlet: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var textViewTermsAndPrivacy : UITextView!
    
    @IBOutlet weak var noThanksButtonOutlet: UIButton! {
        didSet {
            noThanksButtonOutlet.layer.cornerRadius = 16.0
            noThanksButtonOutlet.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var iAgreeButtonOutlet: UIButton! {
        didSet {
            iAgreeButtonOutlet.layer.cornerRadius = 16.0
            iAgreeButtonOutlet.layer.masksToBounds = true
            iAgreeButtonOutlet.isUserInteractionEnabled = false
        }
    }
    
    //MARK: - Variables
    var isSeleted : Bool = false
    var isTerms : Bool = false
    
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
    }
    
    //MARK: - IBActions
    @IBAction func radioButtonPressed(_ sender: Any) {
        radioButtonPressed()
    }
    
    @IBAction func noThanksButtonPressed(_ sender: Any) {
        self.popBackController()
    }
    
    @IBAction func iAgreeButtonPressed(_ sender: Any) {
        if isSeleted {
            self.goToTheAccessDataScreen()
        }
    }
    
    
    //MARK: - Helper Functions
    private func isUserTappedRadioButton() {
        if isSeleted == true {
            self.iAgreeButtonOutlet.alpha = 1.0
            self.iAgreeButtonOutlet.isUserInteractionEnabled = true
            self.radioButtonOutlet.setImage(Constants.Images.IMG_RADIO_FILLED, for: .normal)
        } else {
            self.iAgreeButtonOutlet.alpha = 0.5
            self.iAgreeButtonOutlet.isUserInteractionEnabled = false
            self.radioButtonOutlet.setImage(Constants.Images.IMG_RADIO_HOLLOW, for: .normal)
        }
    }
    
    @objc private func selectedRadioIcon() {
        radioButtonPressed()
    }
    
    private func radioButtonPressed() {
        if isSeleted == true {
            isSeleted = false
        } else {
            isSeleted = true
        }
        isUserTappedRadioButton()
    }
    
    
    private func popBackController() {
        if #available(iOS 13.0, *) {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func goToTheAccessDataScreen() {
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_AUTH, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.ACCESS_DATA) as! AccessDataScreenController
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func goToWebView() {
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_AUTH, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.WEB_VIEW) as! TermsAndPolicyWebViewVC
        vc.navigationController?.isNavigationBarHidden = true
        vc.isTerms = isTerms
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setupTextView(){
        let attributedString = NSMutableAttributedString(string: "I agree to the Terms of Service & Privacy Policy.")
        attributedString.addAttribute(.link, value: "terms://termsofCondition", range: (attributedString.string as NSString).range(of: "Terms of Service"))
        
        attributedString.addAttribute(.link, value: "privacy://privacypolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        textViewTermsAndPrivacy.linkTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.black]
        textViewTermsAndPrivacy.linkTextAttributes = [ NSAttributedString.Key.underlineColor: UIColor.black]
        textViewTermsAndPrivacy.linkTextAttributes = [ NSAttributedString.Key.underlineStyle: 1]
        textViewTermsAndPrivacy.attributedText = attributedString
        textViewTermsAndPrivacy.font = UIFont(name: "Charlie Display", size: 18)
        textViewTermsAndPrivacy.textAlignment = .center
        textViewTermsAndPrivacy.delegate = self
        textViewTermsAndPrivacy.isSelectable = true
        textViewTermsAndPrivacy.isEditable = false
        textViewTermsAndPrivacy.delaysContentTouches = false
        textViewTermsAndPrivacy.isScrollEnabled = false
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "terms" {
            isTerms = true
            goToWebView()
            return false
        } else  if URL.scheme == "privacy"{
            isTerms = false
            goToWebView()
            return false
        }
        return true
    }
}
