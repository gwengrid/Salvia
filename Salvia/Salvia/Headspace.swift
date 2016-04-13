//
//  TodayViewModel.swift
//  Salvia
//
//  Created by gwendolyn weston on 3/9/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import Foundation
import UIKit

enum Headspace {
    case Empty
    case Available
    case Enough

    var defaultString: String {
        switch self {
        case .Empty: return "Nothing to do today!"
        case .Enough: return "Enjoy the rest of your day!"
        case .Available: return ""
        }
    }

    var defaultImage: UIImage? {
        switch self {
        case .Empty: return UIImage(named:"Serene")
        case .Enough: return UIImage(named:"Congrats")
        case .Available: return nil
        }
    }

}
