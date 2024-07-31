//
//  PermissionPopUpVC.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 07/04/2022.
//

import UIKit

class PermissionPopUpVC: UIViewController {
    /* MARK: - Outlets and Properties */
    @IBOutlet weak var viewContentBack : UIView!
    @IBOutlet weak var imgContentView  : UIImageView!
    @IBOutlet weak var lblTitle        : UILabel!
    @IBOutlet weak var lblTitle2       : UILabel!
    @IBOutlet weak var lblTitleDesc    : UILabel!
    @IBOutlet weak var btnAction       : UIButton!
    
    var onDismiss: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
    }
}

/* MARK: - Actions */
extension PermissionPopUpVC{
    @IBAction func didTapActionBtn(_ sender: UIButton){
        print("Action Tapped")
    }
}

/* MARK: - Extensions */
extension PermissionPopUpVC{
    func setupLayouts(){
        lblTitle2.isHidden = true
//        lblTitle2.text = "sdfbao ioewofcas gryg0b09aweucua0"
        viewContentBack.layer.cornerRadius = 30.0
        btnAction.layer.cornerRadius = 15.0
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == self.view {
            print("started")
            self.onDismiss!()
            self.dismiss(animated: false, completion: nil)
        }
    }
}
