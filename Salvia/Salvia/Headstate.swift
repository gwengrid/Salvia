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

extension Headstate {
    init(intention: Intention){
        switch intention {
        case .Being:
            self = .Empty
        case .Setting:
            self = .Available
        case .Doing:
            self = .Enough
        }
    }
}
