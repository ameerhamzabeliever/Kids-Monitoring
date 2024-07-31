//
//  HomeVC.swift
//  LagomKid
//
//  Created by Rao Mudassar Khalil on 05/04/2022.
//

import UIKit
import KDCircularProgress
import Contacts
import CoreData
import CoreLocation
import SwiftyJSON

struct FetchedContact {
    var firstName : String
    var lastName  : String
    var telephone : String
}

class HomeVC: UIViewController {
    /* MARK: - Outlets and Proprties */
    @IBOutlet weak var lblDashboard            : UILabel!
    @IBOutlet weak var lblGreetMsg             : UILabel!
    @IBOutlet weak var lblCode                 : UILabel!
    @IBOutlet weak var lblAppLimit             : UILabel!
    @IBOutlet weak var lblAppLimitDesc         : UILabel!
    @IBOutlet weak var lblAppBlock             : UILabel!
    @IBOutlet weak var lblAppBlockDesc         : UILabel!
    @IBOutlet weak var lblInternetFilter       : UILabel!
    @IBOutlet weak var lblInternetFilterDesc   : UILabel!
    @IBOutlet weak var lblAppLimitTime         : UILabel!
    @IBOutlet weak var lblAppLimitAnimate      : UILabel!
    @IBOutlet weak var viewAppLimit            : UIView!
    @IBOutlet weak var viewCodeBack            : UIView!
    @IBOutlet weak var viewAppBlock            : UIView!
    @IBOutlet weak var viewInternetFilter      : UIView!
    @IBOutlet weak var viewBgProgressBar       : UIView!
    @IBOutlet weak var viewLblAppLimit         : UIView!
    @IBOutlet weak var viewProgressBar         : KDCircularProgress!
    @IBOutlet weak var imgBgGender             : UIImageView!
    @IBOutlet weak var imgBgAppLimit           : UIImageView!
    @IBOutlet weak var imgBgAppBlock           : UIImageView!
    @IBOutlet weak var imgBgInternetFilter     : UIImageView!
    @IBOutlet weak var imgGender               : UIImageView!
    @IBOutlet weak var imgAppBlock             : UIImageView!
    @IBOutlet weak var imgInternetFilter       : UIImageView!
    
    var appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    //contacts
    var contacts = [FetchedContact]()
    var contactRefreshTimer: Timer?
    
    //locations
    var locManager = CLLocationManager()
    var currentLat : Double?
    var currentLong : Double?
    var address : String?
    var locationObj : LocationModel?
    
    //geo fencing
    var fencePlaces = [FencingPlaceModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        setupProgressBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchContactsFromDirectory()
        fetchContactsTimer()
        getCurrentLatLong()
        getCurrentLatLongTimer()
        getFencingPlaces()
    }
}

/* MARK: - Extensions */
    // Layouts
extension HomeVC{
    func setLayouts(){
        viewBgProgressBar.layer.cornerRadius = viewBgProgressBar.frame.size.height / 2
        viewProgressBar.layer.cornerRadius   = viewProgressBar.frame.size.height / 2
        viewLblAppLimit.layer.cornerRadius   = viewLblAppLimit.frame.size.height / 2
        viewAppLimit.layer.cornerRadius = 30.0
        viewAppBlock.layer.cornerRadius = 30.0
        viewInternetFilter.layer.cornerRadius = 30.0
        imgBgGender.layer.cornerRadius = 30.0
        imgBgAppLimit.layer.cornerRadius = 30.0
        imgBgAppBlock.layer.cornerRadius = 30.0
        imgBgInternetFilter.layer.cornerRadius = 30.0
        viewCodeBack.layer.cornerRadius = viewCodeBack.frame.height / 2
        viewCodeBack.layer.borderWidth = 1
        viewCodeBack.layer.borderColor = UIColor.white.cgColor
    }
    func setupProgressBar(){
        viewProgressBar.startAngle = -270
        viewProgressBar.progressThickness = 0.25
        viewProgressBar.trackThickness = 0.4
        viewProgressBar.clockwise = true
        viewProgressBar.gradientRotateSpeed = 2
        viewProgressBar.roundedCorners = true
        viewBgProgressBar.backgroundColor = Constants.Colors.BG_WHITE
        viewLblAppLimit.backgroundColor = Constants.Colors.LIGHT_GREY
        viewProgressBar.set(colors: Constants.Colors.LIGHT_GREY!)
//        viewProgressBar.backgroundColor = Constants.Colors.LIGHT_GREY
//        viewProgressBar.set(colors: Constants.Colors.LIGHT_ORANGE!, ColorConstants.DARK_PINK!)
        viewProgressBar.center = CGPoint(x: view.center.x, y: view.center.y + 25)
        viewProgressBar.animate(fromAngle: 0, toAngle: 350, duration: 2) { completed in
            if completed {
                print("animation completed")
            } else {
                print("animation interrupted")
            }
        }
    }
}

/* MARK: - Extensions */
    // Contact number methods
extension HomeVC{
    func fetchContactsTimer(){
        var bgTask = UIBackgroundTaskIdentifier(rawValue: 0)
        bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(bgTask)
        })
        let timer = Timer.scheduledTimer(timeInterval: 1200, target: self, selector: #selector(fetchContactsFromDirectory), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
    }
    @objc private func fetchContactsFromDirectory(){
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    self.contacts.removeAll()
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        self.contacts.append(FetchedContact(firstName: contact.givenName, lastName: contact.familyName, telephone: contact.phoneNumbers.first?.value.stringValue ?? ""))
                    })
                    print(self.contacts.count)
                    self.fetchContactsFromDB()
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
    func fetchContactsFromDB(){
        let contactList = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entities.CONTACT_LIST)
        do {
            let count = try self.appDel.persistentContainer.viewContext.count(for: contactList)
            print(count)
            if count != 0{
                do {
                    let results = try appDel.persistentContainer.viewContext.fetch(contactList) as? [NSManagedObject]
                    var contactNumber:String? =  ""
                    var userName:String? = ""
                    var time:String? =  ""
                    print(results?.count)
                    if results?.count != contacts.count{
                        deleteContactsFromDB()
                        var param : [String: Any] = [:]
                        var parameter = [param]
                        parameter.removeAll()
                        for index in 0..<self.contacts.count{
                            self.saveContactsInDB(contact: self.contacts[index])
                            param["email"] =  "contact3@email.com"
                            param["contact_id"] = "10"
                            param["name"] = "\( self.contacts[index].firstName) \( self.contacts[index].lastName)"
                            param["phone_home"] =  self.contacts[index].telephone
                            param["phone_work"] =  self.contacts[index].telephone
                            param["phone_mobile"] =  self.contacts[index].telephone
                            parameter.append(param)
                        }
                        shareContacts(params: parameter)
                    }
                    for data in results! { // Atleast one was returned
                        contactNumber = data.value(forKey: "contactNumber") as? String
                        userName = data.value(forKey: "userName") as? String
                        time = data.value(forKey: "time") as? String
                        print(contactNumber,userName,time)
                    }
                } catch {
                    print("Fetch Failed: \(error)")
                }
            }
            else{
                var param : [String: Any] = [:]
                var parameter = [param]
                for index in 0..<self.contacts.count{
                    self.saveContactsInDB(contact: self.contacts[index])
                    param["email"] =  "contact3@email.com"
                    param["contact_id"] = "10"
                    param["name"] = "\( self.contacts[index].firstName) \( self.contacts[index].lastName)"
                    param["phone_home"] =  self.contacts[index].telephone
                    param["phone_work"] =  self.contacts[index].telephone
                    param["phone_mobile"] =  self.contacts[index].telephone
                    parameter.append(param)
                }
                shareContacts(params: parameter)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    func saveContactsInDB(contact : FetchedContact){
        let entity = NSEntityDescription.entity(forEntityName: Constants.Entities.CONTACT_LIST, in:  self.appDel.persistentContainer.viewContext)
        let data = NSManagedObject(entity: entity!, insertInto: self.appDel.persistentContainer.viewContext)
        data.setValue(contact.telephone, forKey: "contactNumber")
        data.setValue("\(contact.firstName) \(contact.lastName)", forKey: "userName")
        let currDate = Helper.getDate()
        print(currDate)
        data.setValue(currDate, forKey: "time")
        self.appDel.saveContext()
    }
    func deleteContactsFromDB(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Constants.Entities.CONTACT_LIST)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try appDel.persistentContainer.viewContext.execute(deleteRequest)
            try appDel.persistentContainer.viewContext.save()
        } catch let error as NSError {
            // TODO: handle the error
            print("connot be deleted")
        }
    }
}

/* MARK: - Extensions */
    // Location methods
extension HomeVC{
    @objc func getCurrentLatLong(){
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        if
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager.location
            currentLat = currentLocation.coordinate.latitude
            currentLong = currentLocation.coordinate.longitude
            print(currentLat, currentLong)
            let latLongaddress = Helper.getAddressFromCoordinates(withLatitude: currentLat ?? 0.0, withLongitude: currentLong ?? 0.0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                self.address = latLongaddress
                print(self.address)
                self.fetchCurrentLocation()
            }
        }
    }
    func getCurrentLatLongTimer(){
        var bgTask = UIBackgroundTaskIdentifier(rawValue: 0)
        bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(bgTask)
        })
        let timer = Timer.scheduledTimer(timeInterval: 1200, target: self, selector: #selector(getCurrentLatLong), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
    }
    func fetchCurrentLocation(){
        let lastLcoation = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entities.LAST_LOCATION)
        do {
            let count = try self.appDel.persistentContainer.viewContext.count(for: lastLcoation)
            print(count)
            if count != 0{
                do {
                    let result = try appDel.persistentContainer.viewContext.fetch(lastLcoation) as? [NSManagedObject]
                    print(result)
                    let lastLat = result?[0].value(forKey: "latitude") as? Double
                    let lastLong = result?[0].value(forKey: "longitude") as? Double
                    let time = result?[0].value(forKey: "time") as? String
                    print(lastLat, lastLong, time)
                    let coordinate₀ = CLLocation(latitude: currentLat ?? 0.0, longitude: currentLong ?? 0.0)
//                    let coordinate₀ = CLLocation(latitude: 36.100012, longitude: 89.0003245)
                    let coordinate₁ = CLLocation(latitude: lastLat ?? 0.0, longitude: lastLong ?? 0.0)
                    let distanceInMeters = coordinate₀.distance(from: coordinate₁) // result is in meters
                    print(distanceInMeters)
                    if distanceInMeters > 100{
                        deleteLocationFromDB()
                        saveCurrentLocation()
                       var param : [String: Any] = [:]
                       var parameter = [param]
                        parameter.removeAll()
                           param["location"] =  address
                           param["latitude"] = result?[0].value(forKey: "latitude") as? Double
                           param["longitude"] =  result?[0].value(forKey: "latitude") as? Double
                           param["time_in"] =  result?[0].value(forKey: "time") as? String
                           param["time_out"] =  result?[0].value(forKey: "time") as? String
                           parameter.append(param)
                        let data =  try! JSONSerialization.data(withJSONObject: parameter, options: [])
                        let par = String(data:data, encoding:.utf8)!
                        param["child_id"] = "111"
                        param["locations"] = par
                        print(param)
                       shareLocation(params: param)
                    }
                    else{
                        print("do nothing")
                    }
                } catch {
                    print("Fetch Failed: \(error)")
                }            }
            else{
                saveCurrentLocation()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    func saveCurrentLocation(){
        let entity = NSEntityDescription.entity(forEntityName: Constants.Entities.LAST_LOCATION, in:  self.appDel.persistentContainer.viewContext)
        let data = NSManagedObject(entity: entity!, insertInto: self.appDel.persistentContainer.viewContext)
        data.setValue(currentLat, forKey: "latitude")
        data.setValue(currentLong, forKey: "longitude")
        let currTimeAndDate = Helper.getDateAndTime()
        print(currTimeAndDate)
        data.setValue(currTimeAndDate, forKey: "time")
        self.appDel.saveContext()
    }
    func deleteLocationFromDB(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Constants.Entities.LAST_LOCATION)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try appDel.persistentContainer.viewContext.execute(deleteRequest)
            try appDel.persistentContainer.viewContext.save()
        } catch let error as NSError {
            // TODO: handle the error
            print("connot be deleted")
        }
    }
}

/* MARK: - Extensions */
    // Fence Place methods
extension HomeVC{
    func saveFencedPlaces(place : FencingPlaceModel){
        let entity = NSEntityDescription.entity(forEntityName: Constants.Entities.FENCE_PLACE, in:  self.appDel.persistentContainer.viewContext)
        let data = NSManagedObject(entity: entity!, insertInto: self.appDel.persistentContainer.viewContext)
        data.setValue(place.place_id, forKey: "place_id")
        data.setValue(place.latitude, forKey: "latitude")
        data.setValue(place.longitude, forKey: "longitude")
        data.setValue(place.address, forKey: "address")
        data.setValue(place.location, forKey: "location")
        data.setValue(place.checkin_alert, forKey: "checkin_alert")
        data.setValue(place.radius, forKey: "radius")
        data.setValue(place.created_at, forKey: "created_at")
        data.setValue(place.updated_at, forKey: "updated_at")
        self.appDel.saveContext()
    }
    func deleteFencePlace(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Constants.Entities.FENCE_PLACE)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try appDel.persistentContainer.viewContext.execute(deleteRequest)
            try appDel.persistentContainer.viewContext.save()
        } catch let error as NSError {
            // TODO: handle the error
            print("connot be deleted")
        }
    }
}

/* MARK: - Api Methods */
extension HomeVC{
    func shareContacts(params : [[String: Any]]){
        var parameters : [String: Any] = [:]
        parameters["contacts"] = params
        NetworkManager.sharedInstance.contacts(param: parameters){
            (response) in
            switch response.result{
            case .success(_):
                do {
                    let apiData = try JSON(data: response.data!)
                    Helper.debugLogs(data: apiData, title: "Api Response")
                    let message = apiData["message"]
                    let status = apiData["status"]
                    if status == 200{
                        print(message)
                    }
                    else{
                        self.ShowErrorAlert(message: message.stringValue)
                    }
                }
                catch {
                    self.showToast(response.error?.localizedDescription ?? "Something went wrong.")
                }
            case .failure(_):
                self.ShowErrorAlert(message: "Something went wrong")
            }
        }
    }
    func shareLocation(params : [String: Any]){
        self.loader(isAnimate: true)
        NetworkManager.sharedInstance.location(param: params){
            (response) in
            self.loader(isAnimate: false)
            switch response.result{
            case .success(_):
                do {
                    let apiData = try JSON(data: response.data!)
                    Helper.debugLogs(data: apiData, title: "Api Response")
                    let message = apiData["message"]
                    let status = apiData["status"]
                    if status == 200{
                        let data = apiData["data"]
                        self.locationObj = LocationModel(json: data)
                        print(self.locationObj)
                    }
                    else{
                        self.ShowErrorAlert(message: message.stringValue)
                    }
                }
                catch {
                    self.showToast(response.error?.localizedDescription ?? "Something went wrong.")
                }
            case .failure(_):
                self.ShowErrorAlert(message: "Something went wrong")
            }
        }
    }
    func getFencingPlaces(){
        self.loader(isAnimate: true)
        NetworkManager.sharedInstance.fencingPlaces{
            (response) in
            self.loader(isAnimate: false)
            switch response.result{
            case .success(_):
                do {
                    let apiData = try JSON(data: response.data!)
                    Helper.debugLogs(data: apiData, title: "Api Response")
                    let message = apiData["message"]
                    let status = apiData["status"]
                    if status == 200{
                        let data = apiData["places"]
                        self.fencePlaces = data.arrayValue.map({FencingPlaceModel(json: $0)})
                        print(self.fencePlaces)
                        self.deleteFencePlace()
                        for index in 0..<self.fencePlaces.count{
                            self.saveFencedPlaces(place: self.fencePlaces[index])
                        }
                    }
                    else{
                        self.ShowErrorAlert(message: message.stringValue)
                    }
                }
                catch {
                    self.showToast(response.error?.localizedDescription ?? "Something went wrong.")
                }
            case .failure(_):
                self.ShowErrorAlert(message: "Something went wrong")
            }
        }
    }
}
