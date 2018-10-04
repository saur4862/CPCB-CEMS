//
//  ProgressiveView.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 01/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

open class ProgressView {
    static let shared = ProgressView()
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    open func showProgressView() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = window.center
        progressView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        UIApplication.shared.keyWindow?.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    
    open func hideProgressView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.containerView.removeFromSuperview()
        }
    }
}
extension UIViewController {
    
    func showAlert(_ title: String?, message: String? , viewController:UIViewController? = nil) {
        
        DispatchQueue.main.async { () -> Void in
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Ok"), style: UIAlertActionStyle.default, handler: nil))
            
            if viewController != nil {
                let hostVC = viewController
                hostVC?.present(alert, animated: true, completion: nil)
            }
            else {
                var hostVC = self.view.window?.rootViewController
                while let next = hostVC?.presentedViewController {
                    hostVC = next
                }
                
                hostVC?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

extension UIView {
    
    class func fromDefaultNibName<T : UIView>(_ nibNameOrNil: String? = nil) -> T {
        let v: T? = fromNibWithName(nibNameOrNil)
        return v!
    }
    
    class func fromNibWithName<T : UIView>(_ nibNameOrNil: String? = nil) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = "\(T.self)".components(separatedBy: ".").last!
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews! {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    func addBorderWidth(_ wid:CGFloat,_ color: UIColor){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = wid
    }
    
    
    func addShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.75).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func addSubview(_ subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
}

