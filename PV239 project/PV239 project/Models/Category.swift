//
//  Category.swift
//  PV239 project
//
//  Created by S T Ξ F A N on 06/04/2019.
//  Copyright © 2019 Jan Crha. All rights reserved.
//

import Foundation

enum Category {
    case Clothes
    case EatingOut
    case Entertainment
    case Fuel
    case Kids
    case Shopping
    case Sport
    case Travel
    
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
        }
    }
}
