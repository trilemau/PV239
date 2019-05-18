//
//  CategoriesTableViewController.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 18/05/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    var addController: AddTransactionTableViewController?
    var editController: TransactionDetailTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            switch indexPath.row {
            case 0:
                addController?.category = Category.Clothes
                editController?.category = Category.Clothes
            case 1:
                addController?.category = Category.EatingOut
                editController?.category = Category.EatingOut
            case 2:
                addController?.category = Category.Entertainment
                editController?.category = Category.Entertainment
            case 3:
                addController?.category = Category.Fuel
                editController?.category = Category.Fuel
            case 4:
                addController?.category = Category.Kids
                editController?.category = Category.Kids
            case 5:
                addController?.category = Category.Shopping
                editController?.category = Category.Shopping
            case 6:
                addController?.category = Category.Sport
                editController?.category = Category.Sport
            case 7:
                addController?.category = Category.Travel
                editController?.category = Category.Travel
            case 8:
                addController?.category = Category.Other
                editController?.category = Category.Other
            default:
                addController?.category = Category.None
                editController?.category = Category.None
            }
        }
        
        if (indexPath.section == 1) {
            switch indexPath.row {
            case 0:
                addController?.category = Category.None
                editController?.category = Category.None
            default:
                addController?.category = Category.None
                editController?.category = Category.None
            }
        }
        
        addController?.categoryImage.image = addController?.category.image
        addController?.categoryField.text = addController?.category.description
        addController?.categorySelected = true
        
        editController?.categoryImage.image = editController?.category?.image
        editController?.categoryField.text = editController?.category?.description
        
        navigationController?.popViewController(animated: true)
    }
}
