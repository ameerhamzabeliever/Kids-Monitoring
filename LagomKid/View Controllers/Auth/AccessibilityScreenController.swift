//
//  AccessibilityScreenController.swift
//  LagomKid
//
//  Created by YumyApps on 07/04/2022.
//

import UIKit

class AccessibilityScreenController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var lagomAccessLabel: UILabel!
    @IBOutlet weak var accessTableView: UITableView!
    
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
    private var accessDataArray = [AccessPermissions]()
    
    //MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableViewNibAndDelegates()
        setDataToArray()
    }

    
    //MARK: - IBActions
    @IBAction func backButtonPressed(_ sender: Any) {
        self.popBackController()
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.goToTheNextScreen()
    }
    
    //MARK: - Helper Functions
    private func popBackController() {
         if #available(iOS 13.0, *) {
             self.navigationController?.popViewController(animated: true)
         }else{
            self.navigationController?.popViewController(animated: true)
         }
     }
    
    private func goToTheNextScreen() {
        let storyboard = UIStoryboard(name: Constants.Strings.STORYBOARD_AUTH, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.LOCK) as! LockScreenController
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func initTableViewNibAndDelegates() {
        self.accessTableView.register(UINib(nibName: Constants.Nib.ACCESSIBILITY_CELL_NIB, bundle: nil), forCellReuseIdentifier: Constants.Nib.ACCESSIBILITY_CELL_NIB)
        self.accessTableView.delegate = self
        self.accessTableView.dataSource = self
    }
    
    private func setDataToArray() {
        self.accessDataArray.append(AccessPermissions(title: Constants.Strings.LOCATION_TITLE, details: Constants.Strings.LOCATION_DETAILS, image: Constants.Images.IMG_LOCATION!))
        self.accessDataArray.append(AccessPermissions(title: Constants.Strings.CONTACTS_TITLE, details: Constants.Strings.CONTACT_DETAILS, image: Constants.Images.IMG_CONTACTS!))
        self.accessDataArray.append(AccessPermissions(title: Constants.Strings.TEXT_MESSAGE_TITLE, details: Constants.Strings.TEXT_MESSAGE_DETAILS, image: Constants.Images.IMG_TEXTMESSAGE!))
        self.accessDataArray.append(AccessPermissions(title: Constants.Strings.STARTUP_TITLE, details: Constants.Strings.STARTUP_DETAILS, image: Constants.Images.IMG_STARTUP!))
        self.accessDataArray.append(AccessPermissions(title: Constants.Strings.BACKGROUND_TITLE, details: Constants.Strings.BACKGROUND_DETAILS, image: Constants.Images.IMG_BACKGROUND!))
        self.accessDataArray.append(AccessPermissions(title: Constants.Strings.STORAGE_TITLE, details: Constants.Strings.STORAGE_DETAILS, image: Constants.Images.IMG_STORAGE!))
        self.accessDataArray.append(AccessPermissions(title: Constants.Strings.INFORMATION_TITLE, details: Constants.Strings.INFORMATION_DETAILS, image: Constants.Images.IMG_INFORMATION!))
        self.accessDataArray.append(AccessPermissions(title: Constants.Strings.PERMISSION_TITLE, details: Constants.Strings.PERMISSION_DETAILS, image: Constants.Images.IMG_PERMISSION!))
        self.accessDataArray.append(AccessPermissions(title: Constants.Strings.USAGE_TITLE, details: Constants.Strings.USAGE_DETAILS, image: Constants.Images.IMG_USAGE!))
    }
}


//MARK: - TableView Delegates and Datasources
extension AccessibilityScreenController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accessDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ACCESSIBILITY_CELL_NIB) as! AccessibilityCustomCell
        cell.setData(data: accessDataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
