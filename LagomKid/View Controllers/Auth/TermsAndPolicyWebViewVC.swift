//
//  TermsAndPolicyWebViewVC.swift
//  LagomKid
//
//  Created by Hamza-Apps on 25/05/2022.
//

import UIKit
import WebKit

class TermsAndPolicyWebViewVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var termsAndPolicyWebView : WKWebView!
    @IBOutlet weak var btnClose : UIButton!
    
    var web     : WKWebView!
    var isTerms : Bool = false
    var url     : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        loadWebView()
    }
    
    @IBAction func didTapClose(_ sender : UIButton){
        popBackController()
    }
    func setupLayouts(){
        btnClose.layer.cornerRadius = 16.0
    }
    private func loadWebView(){
        web = WKWebView(frame: termsAndPolicyWebView.bounds, configuration: WKWebViewConfiguration())
        web.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.termsAndPolicyWebView.addSubview(web)
        if isTerms{
            url = "https://thelagom.app/terms-conditions.html"
        }
        else{
            url = "https://thelagom.app/app-privacy-policy.html"
        }
        let myURL = URL(string: url ?? "")
        let myRequest = URLRequest(url: myURL!)
        web.load(myRequest)
    }
    private func popBackController() {
         if #available(iOS 13.0, *) {
             self.navigationController?.popViewController(animated: true)
         }else{
            self.navigationController?.popViewController(animated: true)
         }
     }
}
