//
//  DashboardTableViewController.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 22/05/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit
import Charts

class DashboardTableViewController: UITableViewController {
    
    @IBOutlet weak var balanceIcon: UIImageView!
    @IBOutlet weak var pieChart: PieChartView!
    
    var incomeData = PieChartDataEntry(value: 0)
    var expenseData = PieChartDataEntry(value: 0)
    var totalData = [PieChartDataEntry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeData.value = 623
        expenseData.value = 132
        
        totalData = [incomeData, expenseData]
        
        updateChartData()
    }
    
    func updateChartData() {
        let dataSet = PieChartDataSet(entries: totalData, label: nil)
        let chartData = PieChartData(dataSet: dataSet)
        
        let colors = [UIColor(named: "IncomeChartColor"), UIColor(named: "ExpenseChartColor")]
        dataSet.colors = colors as! [NSUIColor]
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1
    chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        pieChart.data = chartData
        pieChart.legend.enabled = false
        pieChart.usePercentValuesEnabled = true
    }

}
