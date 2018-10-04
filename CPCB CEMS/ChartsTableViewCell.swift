//
//  ChartsTableViewCell.swift
//  CPCB CEMS
//
//  Created by saurabh srivastava on 01/10/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit
import Charts

class ChartsTableViewCell: UITableViewCell {

    @IBOutlet weak var barView: BarChartView!
    @IBOutlet weak var pieView: PieChartView!
    @IBOutlet weak var statsName: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    var mor:(() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addBorderWidth(0.5,UIColor.black)
        mainView.layer.cornerRadius = 5
    }

    
    @IBAction func more(_ sender: Any) {
        if mor != nil{
            self.mor?()
        }
    }
    func updatePieCharts(_ data:[PieModel],_ str:String){
        pieView.alpha = 1
        barView.alpha = 0
        statsName.text = str
        var total = 0
        for i in data{
            total += i.count
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        let valuesNumberFormatter = ChartValueFormatter(numberFormatter: formatter)
        
        
        let entry1 = PieChartDataEntry(value: Double(data[0].count*100)/Double(total), label: data[0].category)
        let entry2 = PieChartDataEntry(value: Double(data[1].count*100)/Double(total), label: data[1].category)
        let entry3 = PieChartDataEntry(value: Double(data[2].count*100)/Double(total), label: data[2].category)
        let dataSet = PieChartDataSet(values: [entry1, entry2, entry3], label: "")
        
        dataSet.colors = [UIColor(red: 218/255, green: 11/255, blue: 51/255, alpha: 1), UIColor(red: 25/255, green: 184/255, blue: 92/255, alpha: 1), UIColor(red: 34/255, green: 131/255, blue: 246/255, alpha: 1)]
        dataSet.valueFormatter = valuesNumberFormatter
        let data = PieChartData(dataSet: dataSet)
        
        pieView.data = data
        pieView.transparentCircleColor = UIColor.clear
        pieView.holeRadiusPercent = 0.0
        pieView.centerText = ""
        pieView.chartDescription?.text = ""
        
        pieView.notifyDataSetChanged()
    }
    
    func updateBarCharts(_ data:[PieModel],_ str:String){
        pieView.alpha = 0
        barView.alpha = 1
        statsName.text = str
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(data[0].count))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(data[1].count))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(data[2].count))
        let chartDataSet = BarChartDataSet(values: [entry1], label: data[0].category)
        let chartDataSet1 = BarChartDataSet(values: [entry2], label: data[1].category)
        let chartDataSet2 = BarChartDataSet(values: [entry3], label: data[2].category)
        chartDataSet.colors = [UIColor(red: 218/255, green: 11/255, blue: 51/255, alpha: 1)]
        chartDataSet1.colors = [UIColor(red: 25/255, green: 184/255, blue: 92/255, alpha: 1)]
        chartDataSet2.colors = [UIColor(red: 34/255, green: 131/255, blue: 246/255, alpha: 1)]
        var dataSets:[BarChartDataSet] = [chartDataSet,chartDataSet1,chartDataSet2]
        let chartData = BarChartData(dataSets: dataSets)
        barView.leftAxis.drawGridLinesEnabled = false
        barView.rightAxis.enabled = false
        let xaxis = barView.xAxis
        xaxis.drawGridLinesEnabled = false
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.drawLabelsEnabled = true
        var names = ["",data[0].categoryType.capitalized,""]
        xaxis.valueFormatter = IndexAxisValueFormatter(values:names)
        //   xaxis.valueFormatter = IndexAxisValueFormatter(values: [data[0].category])
        xaxis.granularity = 1
        barView.data = chartData
        barView.chartDescription?.text = ""
        
        barView.notifyDataSetChanged()
    }
    
    func updateMultibarCharts(_ data:[BarModel],_ str:String){
        pieView.alpha = 0
        barView.alpha = 1
        statsName.text = str
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []
        for i in 0..<3 {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(data[i].live))
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i)+0.3 , y: Double(data[i].delayed))
            dataEntries1.append(dataEntry1)
            
            let dataEntry2 = BarChartDataEntry(x: Double(i)+0.6 , y: Double(data[i].offline))
            dataEntries2.append(dataEntry2)
            
            
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Live")
        let chartDataSet1 = BarChartDataSet(values: dataEntries1, label: "Delayed")
        let chartDataSet2 = BarChartDataSet(values: dataEntries2, label: "Offline")
        chartDataSet.colors = [UIColor(red: 218/255, green: 11/255, blue: 51/255, alpha: 1)]
        chartDataSet1.colors = [UIColor(red: 25/255, green: 184/255, blue: 92/255, alpha: 1)]
        chartDataSet2.colors = [UIColor(red: 34/255, green: 131/255, blue: 246/255, alpha: 1)]
        var dataSets:[BarChartDataSet] = [chartDataSet,chartDataSet1,chartDataSet2]
        let chartData = BarChartData(dataSets: dataSets)
        chartData.barWidth = 0.3
        barView.leftAxis.drawGridLinesEnabled = false
        barView.rightAxis.enabled = false
        let xaxis = barView.xAxis
        xaxis.drawGridLinesEnabled = false
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.drawLabelsEnabled = true
        var names = [data[0].category.capitalized, data[1].category.capitalized,data[2].category.capitalized]
        xaxis.valueFormatter = IndexAxisValueFormatter(values:names)
     //   xaxis.valueFormatter = IndexAxisValueFormatter(values: [data[0].category])
        xaxis.granularity = 1
        barView.data = chartData
        barView.chartDescription?.text = ""
        
        barView.notifyDataSetChanged()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

class ChartValueFormatter: NSObject, IValueFormatter {
    fileprivate var numberFormatter: NumberFormatter?
    
    convenience init(numberFormatter: NumberFormatter) {
        self.init()
        self.numberFormatter = numberFormatter
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        guard let numberFormatter = numberFormatter
            else {
                return ""
        }
        return numberFormatter.string(for: value)!
    }
}
