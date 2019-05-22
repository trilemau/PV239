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
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var balanceIcon: UIImageView!
    @IBOutlet weak var balanceField: UILabel!
    @IBOutlet weak var incomeField: UILabel!
    @IBOutlet weak var expenseField: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    
    var transactions: [Transaction] = []
    var income: Int = 0
    var expense: Int = 0
    var balance: Int = 0
    var segment: Int?
    
    var incomeData = PieChartDataEntry(value: 0)
    var expenseData = PieChartDataEntry(value: 0)
    var totalData = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segment = segmentControl.selectedSegmentIndex
        
        updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateView()
    }
    
    func updateTransactions() {
        switch segment {
        case 0:
            transactions = TransactionsManager.shared.getTransactions()
        case 1:
            transactions = getThisMonthTransactions()
        case 2:
            transactions = getTodayTransactions()
        default:
            return
        }
    }
    
    func calculateData() {
        income = 0
        expense = 0
        
        for transaction in transactions {
            if (transaction.transactionType == TransactionType.Income) {
                income += transaction.amount!
            }
            
            if (transaction.transactionType == TransactionType.Expense) {
                expense += transaction.amount!
            }
        }
        
        balance = income - expense
    }
    
    func updateView() {
        updateTransactions()
        calculateData()
        
        var sign = ""
        
        balanceIcon.image = getBalanceIcon()
        
        if (balance < 0) {
            balanceField.textColor = UIColor(named: "ExpenseColor")
        } else if (balance > 0) {
            sign = "+"
            balanceField.textColor = UIColor(named: "IncomeColor")
        } else {
            balanceField.textColor = UIColor.black
        }
            
        balanceField.text = "\(sign)\(balance.formattedWithSeparator) Kč"
        
        incomeField.text = "+\(income.formattedWithSeparator) Kč"
        expenseField.text = "-\(expense.formattedWithSeparator) Kč"
        
        updateChartData()
    }
    
    func getBalanceIcon() -> UIImage {
        if (balance < 0) {
            return #imageLiteral(resourceName: "ExpenseIcon")
        } else if (balance > 0) {
            return #imageLiteral(resourceName: "IncomeIcon")
        } else {
            return #imageLiteral(resourceName: "NoneIcon")
        }
    }
    
    func getThisMonthTransactions() -> [Transaction] {
        var output: [Transaction] = []
        
        for transaction in TransactionsManager.shared.getTransactions() {
            let transactionMonth = Calendar.current.component(Calendar.Component.month, from: transaction.date!)
            let transactionYear = Calendar.current.component(Calendar.Component.year, from: transaction.date!)
            
            let currentMonth = Calendar.current.component(Calendar.Component.month, from: Date())
            let currentYear = Calendar.current.component(Calendar.Component.year, from: Date())
            
            if (transactionMonth == currentMonth && transactionYear == currentYear) {
                output.append(transaction)
            }
        }
        
        return output
    }
    
    func getTodayTransactions() -> [Transaction] {
        var output: [Transaction] = []
        
        for transaction in TransactionsManager.shared.getTransactions() {
            if (Calendar.current.isDateInToday(transaction.date!)) {
                output.append(transaction)
            }
        }
        
        return output
    }
    
    func updateChartData() {
        incomeData.value = Double(income)
        expenseData.value = Double(expense)
        
        totalData = [incomeData, expenseData]
        
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

    @IBAction func segmentControlClicked(_ sender: UISegmentedControl) {
        segment = segmentControl.selectedSegmentIndex
        
        updateView()
    }
}
