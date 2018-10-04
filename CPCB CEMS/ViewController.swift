//
//  ViewController.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 01/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateNavView()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func updateNavView(){
        let navView = NavigationView.fromNibWithName("NavigationView") as! NavigationView
        navView.backWidth.constant = 0
        navView.heading.text = "User Details"
        navView.goBacks = {[weak self] () -> Void in
            self?.navigationController?.popViewController(animated: true)
        }
        topView.addSubview(navView, toView: topView)
    }
    

    @IBAction func submitAction(_ sender: Any) {
        let phn = phone.text!
        let email = emailId.text!
        let user = userName.text!
        
        if user != "" && isValidEmail(true, email) && validatePhone(phn){
            let dict = ["name": user,
                        "phone": phn,
                        "emailId":email]
            ProgressView.shared.showProgressView()
            ApiService.sharedInstance.postUserDetailsForVerfication(dict, {[weak self] (result,error) -> Void in
                ProgressView.shared.hideProgressView()
                if error == nil{
                    let controller = self?.storyboard?.instantiateViewController(withIdentifier: "VerifyViewController") as!
                    VerifyViewController
                    controller.userData = dict
                    self?.navigationController?.pushViewController(controller, animated: true)
                }
                else{
                    self?.showAlert(error?.title, message: error?.description)
                }
            })
        }
        else if isValidEmail(true, email) == false{
            self.showAlert("Invalid EmailId", message: "Please enter valid email Id")
        }
        else if validatePhone(phn) == false{
            self.showAlert("Invalid phone number", message: "Please enter valid number")
        }
        else{
            self.showAlert("Enter all details", message: "Please enter all details")
        }
    }
    
    
    func isValidEmail(_ strict:Bool, _ str:String)->Bool{
        let stricterFilterString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let laxString = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let emailRegex = strict ? stricterFilterString : laxString
        let emailTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: str)
    }
    
    func validatePhone( _ str:String) -> Bool {
        let charcter  = NSCharacterSet(charactersIn: "0123456789").inverted
        var filtered:NSString!
        let inputString:NSArray = str.components(separatedBy: charcter) as NSArray
        filtered = inputString.componentsJoined(by: "") as NSString?
        return  str == String(filtered) && str.count == 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

