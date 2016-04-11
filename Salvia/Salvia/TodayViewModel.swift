//
//  TodayViewModel.swift
//  Salvia
//
//  Created by gwendolyn weston on 3/9/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import Foundation
import UIKit

enum TodayState {
    case Empty
    case Completed

    var defaultString: String {
        switch self {
        case .Empty: return "Nothing to do today!"
        case .Completed: return "Enjoy the rest of your day!"
        default: return ""
        }
    }

    var defaultImage: UIImage? {
        switch self {
        case .Empty: return UIImage(named:"Serene")
        case .Completed: return UIImage(named:"Congrats")
        default: return nil
        }
    }

}

extension TodayState {
    init(task: Task?) {
        switch task {
        case nil:
            self = .Empty
        case let task where task?.wasCompletedToday() == true:
            self = .Completed
        default:
            self = .Present
        }
    }
}
