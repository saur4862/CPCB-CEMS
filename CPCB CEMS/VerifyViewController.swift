//
//  VerifyViewController.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 02/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class VerifyViewController: UIViewController {

    @IBOutlet weak var verifyField: UITextField!
    
    @IBOutlet weak var topView: UIView!
    var userData = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavView()
    }

    func updateNavView(){
        let navView = NavigationView.fromNibWithName("NavigationView") as! NavigationView
        navView.backWidth.constant = 45
        navView.heading.text = "Verify Code"
        navView.goBacks = {[weak self] () -> Void in
            self?.navigationController?.popViewController(animated: true)
        }
        topView.addSubview(navView, toView: topView)
    }

    @IBAction func verify(_ sender: Any) {
        userData["token"] = verifyField.text!
        ProgressView.shared.showProgressView()
        ApiService.sharedInstance.postVerifyDetails(userData, {[weak self] (result,error) -> Void in
            ProgressView.shared.hideProgressView()
            if error == nil{
                DispatchQueue.main.async {
                    let controller = self?.storyboard?.instantiateViewController(withIdentifier: "UploadDataViewController") as! UploadDataViewController
                    controller.userData = self!.userData
                    self?.navigationController?.pushViewController(controller, animated: true)
                }
            }
            else{
                self?.showAlert(error?.title, message: error?.message)
            }
        })
    }
}
