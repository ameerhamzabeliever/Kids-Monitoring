//
//  AccessibilityCustomCell.swift
//  LagomKid
//
//  Created by YumyApps on 07/04/2022.
//

import UIKit

class AccessibilityCustomCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var accessImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    //MARK: - View LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    //MARK: - Helper Functions
    func setData(data:AccessPermissions?) {
        self.accessImageView.image = data?.image 
        self.titleLabel.text = data?.title ?? ""
        self.detailsLabel.text = data?.details ?? ""
    }
}
