//
//  CategoriesViewController.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 01/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    var navView:NavigationView!
    var cates = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        updateNavView()
        getCategories()
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }

    func getCategories(){
        ProgressView.shared.showProgressView()
        ApiService.sharedInstance.getCategories({[weak self] (result,error) -> Void in
            ProgressView.shared.hideProgressView()
            if error == nil{
                if let res = result as? [Category]{
                    self?.cates = res
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
            
        })
    }
    
    func updateNavView(){
        navView = NavigationView.fromNibWithName("NavigationView") as! NavigationView
        navView.backWidth.constant = 0
        navView.heading.text = "Categories"
        topView.addSubview(navView, toView: topView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let det = cates[indexPath.row]
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailsViewController") as! CategoryDetailsViewController
        controller.category = det
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.updateCell(cates[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
