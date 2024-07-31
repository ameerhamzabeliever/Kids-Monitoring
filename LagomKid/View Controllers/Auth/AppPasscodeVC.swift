//
//  AppPasscodeVC.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 12/04/2022.
//

import UIKit

class AppPasscodeVC: UIViewController {
    
    /* MARK: - Outlets and Properties */
    @IBOutlet weak var lblTitleAppPasscode : UILabel!
    @IBOutlet weak var lblDescAppPasscode  : UILabel!
    @IBOutlet weak var tfPasscode          : UITextField!
    @IBOutlet weak var btnPasscode         : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
    }
}

/* MARK: - Actions */
extension AppPasscodeVC{
    @IBAction func didTapPasscode(_ sender : UIButton){
        print("passcode tapped")
    }
}

/* MARK: - Extension */
extension AppPasscodeVC{
    func setupLayouts(){
        btnPasscode.layer.cornerRadius = 15.0
    }
}
