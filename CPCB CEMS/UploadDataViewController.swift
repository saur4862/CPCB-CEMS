//
//  UploadDataViewController.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 03/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit
import CoreLocation

class UploadDataViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var photoField: UITextField!
    @IBOutlet weak var topView: UIView!
    var imagePicker: UIImagePickerController!
    var selectedImage:UIImage!
    var userData = [String:String]()
    let locationManager = CLLocationManager()
    var city = ""
    var country = ""
    var state = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateNavView()
    }

    func updateNavView(){
        let navView = NavigationView.fromNibWithName("NavigationView") as! NavigationView
        navView.backWidth.constant = 45
        navView.heading.text = "Upload Images"
        navView.goBacks = {[weak self] () -> Void in
            self?.navigationController?.popViewController(animated: true)
        }
        topView.addSubview(navView, toView: topView)
    }
    
    @IBAction func changeUser(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func submit(_ sender: Any) {
        if selectedImage != nil{
        userData["city"] = city
        userData["country"] = country
        userData["state"] = state
        userData["location"] = (locationManager.location?.coordinate.latitude.description)!+"#"+(locationManager.location?.coordinate.longitude.description)!
        ProgressView.shared.showProgressView()
        ApiService.sharedInstance.postAndUploadImages(selectedImage,userData, {[weak self] (result,error) -> Void in
            ProgressView.shared.hideProgressView()
            if error == nil{
                DispatchQueue.main.async {
                    self?.showAlert("Images Uploaded", message: "Images have been uplaoded")
                }
            }
        })
        }
        
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        if picker.allowsEditing{
            selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        }
        else{
            selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        photoField.text = "Uploaded the pic"
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        selectedImage = image
        photoField.text = "Uploaded the pic"
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkLocation(_ sender: Any) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setUsersClosestCity()
    }
    @nonobjc func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func setUsersClosestCity(){
        let geoCoder = CLGeocoder()
        let location = locationManager.location
        if location != nil{
            geoCoder.reverseGeocodeLocation(location!)
            {
                (placemarks, error) -> Void in
                    if error == nil{
                        let placeArray = placemarks as [CLPlacemark]?
                        var placeMark: CLPlacemark!
                        placeMark = placeArray?[0]
                    
                        // City
                        if let kcity = placeMark.addressDictionary?["City"] as? NSString
                        {
                            self.city = kcity as! String
                            self.locationField.text = kcity as! String
                        }
                        if let country = placeMark.addressDictionary?["Country"] as? NSString
                        {
                            self.country = country as! String
                        }
                        if let country = placeMark.addressDictionary?["State"] as? NSString
                        {
                            self.state = country as! String
                        }
                        
                }
            }
        }
    }
}
