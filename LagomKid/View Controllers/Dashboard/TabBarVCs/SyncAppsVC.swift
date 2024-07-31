//
//  SyncAppsVC.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 06/04/2022.
//

import UIKit

class SyncAppsVC: UIViewController {
    
    /* MARK: - Outlets and Properties */
    @IBOutlet weak var lblSyncApps          : UILabel!
    @IBOutlet weak var lblStayConnected     : UILabel!
    @IBOutlet weak var lblStayConnectedDesc : UILabel!
    @IBOutlet weak var btnOk                : UIButton!
    @IBOutlet weak var viewBgSyncApps       : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
    }
}

/* MARK: - Actions */
extension SyncAppsVC{
    @IBAction func didTapOk(_ sender : UIButton){
        print("Oktapped")
    }
}

/* MARK: - Extensions */
extension SyncAppsVC{
    func setupLayouts(){
        btnOk.layer.cornerRadius = 15.0
        viewBgSyncApps.layer.cornerRadius = 25.0
        Helper.addShadow(viewBgSyncApps)
    }
}
