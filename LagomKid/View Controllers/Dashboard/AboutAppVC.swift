//
//  AboutAppVC.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 07/04/2022.
//

import UIKit

class AboutAppVC: UIViewController {
    /* MARK: - Outlets and Properties */
    @IBOutlet weak var btnBack           : UIButton!
    @IBOutlet weak var viewBgAboutApp    : UIView!
    @IBOutlet weak var lblTitleAboutApp  : UILabel!
    @IBOutlet weak var lblTitleLagom     : UILabel!
    @IBOutlet weak var lblLagomDesc      : UILabel!
    @IBOutlet weak var lblCurrentVersion : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
    }
}

/* MARK: - Actions */
extension AboutAppVC{
    @IBAction func didTapBack(_ sender : UIButton){
        print("back tapped")
        self.navigationController?.popViewController(animated: true)
    }
}

/* MARK: - Extensions */
extension AboutAppVC{
    func setupLayouts(){
        btnBack.layer.cornerRadius = 15.0
        viewBgAboutApp.layer.cornerRadius = 25.0
        Helper.addShadow(viewBgAboutApp)
    }
}
