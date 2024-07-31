//
//  CheckPermissionVC.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 07/04/2022.
//

import UIKit

class CheckPermissionVC: UIViewController {
    
    /* MARK: - Outlets and Properties */
    @IBOutlet weak var lblCheckPermission       : UILabel!
    @IBOutlet weak var lblPermissionGranted     : UILabel!
    @IBOutlet weak var lblPermissionGrantedDesc : UILabel!
    @IBOutlet weak var btnBack                  : UIButton!
    @IBOutlet weak var viewBgPermissionGranted  : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
    }
}

/* MARK: - Actions */
extension CheckPermissionVC{
    @IBAction func didTapBack(_ sender : UIButton){
        print("back tapped")
        self.navigationController?.popViewController(animated: true)
    }
}

/* MARK: - Extensions */
extension CheckPermissionVC{
    func setupLayouts(){
        btnBack.layer.cornerRadius = 15.0
        viewBgPermissionGranted.layer.cornerRadius = 25.0
        Helper.addShadow(viewBgPermissionGranted)
    }
}
