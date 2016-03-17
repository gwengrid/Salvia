//
//  TodayViewModel.swift
//  Salvia
//
//  Created by gwendolyn weston on 3/9/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import Foundation
import RxCocoa

enum TodayState {
    case Empty
    case Completed
    case Present
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

    func completionButtonState() -> Bool{
        switch self {
        case .Empty, .Completed: return true
        case .Present: return false
        }
    }

    func defaultString() -> String {
        switch self {
        case .Empty: return "Nothing today.  Treat yourself!"
        case .Completed: return "Good job!"
        default: return ""
        }
    }
}
