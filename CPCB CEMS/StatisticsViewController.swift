//
//  StatisticsViewController.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 01/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    var titleHeaders = ["Most Violating State","Most Violating Sectors","Most Violating Effluent Parameter", "Most Violating Emission Parameters","Live Data Feed","State Alarms","Industry Alarm"]
    
    var datas = [String:Any]()
    
    var navView:NavigationView!
    
    var live = 0
    var indus = 0
    
    var queue = OperationQueue()
    
    var context = "context"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateNavView()
        ProgressView.shared.showProgressView()
        self.getCalls()
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        tableView.register(UINib(nibName: "ChartsTableViewCell", bundle: nil), forCellReuseIdentifier: "ChartsTableViewCell")
        
    }
    
    
   
    
    func updateNavView(){
        navView = NavigationView.fromNibWithName("NavigationView") as! NavigationView
        navView.backWidth.constant = 0
        navView.heading.text = "Statistics"
        topView.addSubview(navView, toView: topView)
    }
    
    //MARK:: API Calling
    
    func getCalls(){
      
        let op1 = BlockOperation(block: {
            ApiService.sharedInstance.getLiveCount({[weak self] (result,error) -> Void in
                if error == nil{
                    if let int = result as? Int{
                        self?.live = int
                    }
                }
            })
        })
        op1.addExecutionBlock({ () -> Void in
            ApiService.sharedInstance.getIndusCount({[weak self] (result,error) -> Void in
                if error == nil{
                    if let int = result as? Int{
                        self?.indus = int
                    }
                }
            })
        })
       op1.addExecutionBlock({
            ApiService.sharedInstance.getMaxViolatingState({[weak self] (result,error) -> Void in
                if error == nil{
                    if let data = result as? [PieModel]{
                        self?.datas[self!.titleHeaders[0]] = data
                    }
                }
            })
        })
       
        op1.addExecutionBlock({
            ApiService.sharedInstance.getMaxViolatingCategory({[weak self] (result,error) -> Void in
                if error == nil{
                    if let data = result as? [PieModel]{
                        self?.datas[self!.titleHeaders[1]] = data
                    }
                }
            })
        })
        op1.addExecutionBlock({
            ApiService.sharedInstance.getMaxViolatingEffulent({[weak self] (result,error) -> Void in
                if error == nil{
                    if let data = result as? [PieModel]{
                        self?.datas[self!.titleHeaders[2]] = data
                    }
                }
            })
        })
        op1.addExecutionBlock({
            ApiService.sharedInstance.getMaxViolatingCategoryEmission({[weak self] (result,error) -> Void in
                if error == nil{
                    if let data = result as? [PieModel]{
                        self?.datas[self!.titleHeaders[3]] = data
                    }
                }
            })
        })
        op1.addExecutionBlock({
            ApiService.sharedInstance.getLiveDataFeed({[weak self] (result,error) -> Void in
                if error == nil{
                    if let data = result as? [BarModel]{
                        self?.datas[self!.titleHeaders[4]] = data
                    }
                }
            })
        })
        op1.addExecutionBlock({
            ApiService.sharedInstance.getStateAlarm({[weak self] (result,error) -> Void in
                if error == nil{
                    if let data = result as? [PieModel]{
                        self?.datas[self!.titleHeaders[5]] = data
                    }
                }
            })
        })
       op1.addExecutionBlock( {
            ApiService.sharedInstance.getIndustryAlarm({[weak self] (result,error) -> Void in
                if error == nil{
                    if let data = result as? [PieModel]{
                        self?.datas[self!.titleHeaders[6]] = data
                    }
                }
            })
         })
        let completionOperation = BlockOperation(block: {
            sleep(2)
            DispatchQueue.main.async {
                ProgressView.shared.hideProgressView()
                self.tableView.reloadData()
            }
        })
        completionOperation.addDependency(op1)
        queue.addOperation(op1)
        queue.addOperation(completionOperation)
        queue.waitUntilAllOperationsAreFinished()
        
    }

    
    
    //MARK:: TABLE VIEW DELEGATES
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleHeaders.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.livePoint.text = String(live)
            cell.indusPoint.text = String(indus)
            return cell
        }
        else{
             let cell = self.tableView.dequeueReusableCell(withIdentifier: "ChartsTableViewCell", for: indexPath) as! ChartsTableViewCell
            if let data = datas[titleHeaders[indexPath.row-1]] as? [PieModel]{
                if indexPath.row < 5{
                    cell.updatePieCharts(data, titleHeaders[indexPath.row-1])
                }
                else{
                    cell.updateBarCharts(data, titleHeaders[indexPath.row-1])
                }
            }
            if let data =  datas[titleHeaders[indexPath.row-1]] as? [BarModel]{
                cell.updateMultibarCharts(data, titleHeaders[indexPath.row-1])
            }
            cell.mor = {[weak self] () -> Void in
                let controller = self?.storyboard?.instantiateViewController(withIdentifier: "ExceeDetailsViewController") as! ExceeDetailsViewController
                if let data = self?.datas[self!.titleHeaders[indexPath.row-1]] as? [PieModel]{
                    controller.pie = data
                }
                if let data = self?.datas[self!.titleHeaders[indexPath.row-1]] as? [BarModel]{
                    controller.bar = data
                }
                self?.present(controller, animated: true, completion: nil)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 140
        }
        else{
            return 350
        }
    }
   
}
