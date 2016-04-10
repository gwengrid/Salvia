//
//  PresentationState.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/9/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit

enum StickyParadigm {
    case Ease
    case Intention
    case Arrived
}

struct StickyLayout {
    var paradigm: StickyParadigm {
        willSet {
            NSLayoutConstraint.deactivateConstraints(definingConstraints)
        }
        didSet {
            NSLayoutConstraint.activateConstraints(definingConstraints)
        }
    }

    let easeConstraints: [NSLayoutConstraint]
    let intentionConstraints: [NSLayoutConstraint]
    let arrivedConstraints: [NSLayoutConstraint]

    var taskTextAlpha: CGFloat {
        switch paradigm {
            case .Ease:
                return 0
            case .Intention, .Arrived:
                return 1
        }
    }

    var taskTextEditable: Bool {
        switch paradigm {
        case .Ease, .Arrived:
            return false
        case .Intention:
            return true
        }
    }

    var taskDateAlpha: CGFloat {
        switch paradigm {
        case .Ease, .Intention:
            return 0
        case .Arrived:
            return 1
        }
    }

    var cancelButtonAlpha: CGFloat {
        switch paradigm {
        case .Arrived, .Ease:
            return 0
        case .Intention:
            return 1
        }
    }

    var definingConstraints: [NSLayoutConstraint] {
        switch paradigm {
        case .Ease:
            return easeConstraints
        case .Intention:
            return intentionConstraints
        case .Arrived:
            return arrivedConstraints
        }
    }
}

