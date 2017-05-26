//
//  SRSStatus.swift
//  WaniKani
//
//  Created by Andrii Kharchyshyn on 5/26/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import UIKit

enum SRSStatus: String {
    case apprentice
    case guru
    case master
    case enlighten
    case burned

    var icon: UIImage {
        switch self {
        case .apprentice: return #imageLiteral(resourceName: "apprentice")
        case .guru: return #imageLiteral(resourceName: "guru")
        case .master: return #imageLiteral(resourceName: "master")
        case .enlighten: return #imageLiteral(resourceName: "enlighten")
        case .burned: return #imageLiteral(resourceName: "burned")
        }
    }

    var color: UIColor {
        switch self {
        case .apprentice: return UIColor(red:0.95, green:0.00, blue:0.62, alpha:1.00)
        case .guru: return UIColor(red:0.62, green:0.17, blue:0.70, alpha:1.00)
        case .master: return UIColor(red:0.26, green:0.37, blue:0.86, alpha:1.00)
        case .enlighten: return UIColor(red:0.00, green:0.59, blue:0.88, alpha:1.00)
        case .burned: return UIColor(red:0.28, green:0.28, blue:0.28, alpha:1.00)
        }
    }
}
