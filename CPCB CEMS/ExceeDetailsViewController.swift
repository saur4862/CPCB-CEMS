//
//  ExceeDetailsViewController.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 02/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class ExceeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var pie = [PieModel]()
    var bar = [BarModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ExceeDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ExceeDetailsTableViewCell")
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bar.count > 0{
            return bar.count
        }
        return pie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExceeDetailsTableViewCell", for: indexPath) as! ExceeDetailsTableViewCell
        if pie.count > 0{
            cell.label1.text = pie[indexPath.row].category
            cell.label2.text = String(pie[indexPath.row].count)
        }
        else{
            cell.label1.text = bar[indexPath.row].category
            cell.label2.text = String(bar[indexPath.row].live)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        view.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        let label = UILabel(frame:CGRect(x: 0, y: 0, width: self.view.frame.width/2, height: 40))
        let label2 = UILabel(frame:CGRect(x: self.view.frame.width/2, y: 0, width: self.view.frame.width/2, height: 40))
        label.textAlignment = .center
        label2.textAlignment = .center
        label2.text = "Count"
        label.text = "State"
        if pie.count > 0{
            label.text = pie[0].categoryType.capitalized
        }
        view.addSubview(label)
        view.addSubview(label2)
        return view
    }
    
   

}
