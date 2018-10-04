//
//  CategoryDetailsViewController.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 02/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class CategoryDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
     @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var catDetails = [CategoryDetails]()
    
    var category:Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavView()
        self.getDetails()
        self.tableView.register(UINib(nibName: "CategoryDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryDetailTableViewCell")
        
    }
    
    func getDetails(){
        if category != nil{
            ProgressView.shared.showProgressView()
            ApiService.sharedInstance.getCategoryDetails(category.id, {[weak self] (result,error) -> Void in
                ProgressView.shared.hideProgressView()
                if error == nil{
                    if let res = result as? [CategoryDetails]{
                        self?.catDetails = res
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                }
                
            })
        }
    }

    func updateNavView(){
        let navView = NavigationView.fromNibWithName("NavigationView") as! NavigationView
        navView.backWidth.constant = 45
        navView.heading.text = category.type.capitalized
        navView.goBacks = {[weak self] () -> Void in
            self?.navigationController?.popViewController(animated: true)
        }
        topView.addSubview(navView, toView: topView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CategoryDetailTableViewCell", for: indexPath) as! CategoryDetailTableViewCell
        let det = catDetails[indexPath.row]
        cell.param.text = det.param
        cell.minLabel.text = String(det.min)
        cell.maxLabel.text = String(det.max)
        cell.unit.text = String(det.unit)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catDetails.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CategoryDetailsHeaderView.fromNibWithName("CategoryDetailsHeaderView") as! CategoryDetailsHeaderView
        return view
    }
    
}
