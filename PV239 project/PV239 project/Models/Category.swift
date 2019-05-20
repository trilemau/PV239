//
//  Category.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 06/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import Foundation
import UIKit

enum Category {
    case Clothes
    case EatingOut
    case Entertainment
    case Fuel
    case Kids
    case Shopping
    case Sport
    case Travel
    case Other
    case None
    
    var description: String {
        switch self {
            case .Clothes: return "Clothes"
            case .EatingOut: return "Eating out"
            case .Entertainment: return "Entertainment"
            case .Fuel: return "Fuel"
            case .Kids: return "Kids"
            case .Shopping: return "Shopping"
            case .Sport: return "Sport"
            case .Travel: return "Travel"
            case .Other: return "Other"
            case .None: return "None"
        }
    }
    
    var image: UIImage {
        switch self {
            case .Clothes: return #imageLiteral(resourceName: "ClothesIcon")
            case .EatingOut: return #imageLiteral(resourceName: "EatingOutIcon")
            case .Entertainment: return #imageLiteral(resourceName: "EntertainmentIcon")
            case .Fuel: return #imageLiteral(resourceName: "FuelIcon")
            case .Kids: return #imageLiteral(resourceName: "KidsIcon")
            case .Shopping: return #imageLiteral(resourceName: "ShoppingIcon")
            case .Sport: return #imageLiteral(resourceName: "SportsIcon")
            case .Travel: return #imageLiteral(resourceName: "TravelIcon")
            case .Other: return #imageLiteral(resourceName: "SpendingIcon")
            case .None: return #imageLiteral(resourceName: "NoneIcon")
        }
    }
}
