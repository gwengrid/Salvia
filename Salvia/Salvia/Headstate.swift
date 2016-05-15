//
//  TodayViewModel.swift
//  Salvia
//
//  Created by gwendolyn weston on 3/9/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import Foundation
import UIKit

enum Headstate {
    case Empty
    case Enough

    var defaultString: String {
        switch self {
        case .Empty: return "Nothing to do today!"
        case .Enough: return "Enjoy the rest of your day!"
        }
    }

    var defaultImage: UIImage? {
        switch self {
        case .Empty: return UIImage(named:"Serene")
        case .Enough: return UIImage(named:"Congrats")
        }
    }
}
