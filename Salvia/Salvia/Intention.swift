//
//  Paradigm.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/11/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit

enum Intention {
    case Being
    case Setting
    case Doing
}

enum Interaction {
    case Invisible
    case Visible
    case Editable
}

struct Layout {
    let beingLayout: [NSLayoutConstraint]
    let settingLayout: [NSLayoutConstraint]
    let doingLayout: [NSLayoutConstraint]

    var intention: Intention {
        willSet {
            NSLayoutConstraint.deactivateConstraints(definingConstraints)
        }
        didSet {
            NSLayoutConstraint.deactivateConstraints(definingConstraints)
        }
    }

    var definingConstraints: [NSLayoutConstraint] {
        switch intention {
        case .Being:
            return beingLayout
        case .Setting:
            return settingLayout
        case .Doing:
            return doingLayout
        }
    }
    
    var taskTextAlpha: CGFloat {
        return intention == .Being ? 0 : 1
    }

    var taskTextEditable: Bool {
        return intention == .Setting ? true : false
    }

    var taskDateAlpha: CGFloat {
        return intention == .Doing ? 1 : 0
    }

    var cancelButtonAlpha: CGFloat {
        return intention == .Setting ? 1 : 0
    }

    var actionButtonImage: UIImage {
        if let image = intention == .Doing ? UIImage(named: "CheckButton") : UIImage(named: "AddButton") {
            return image
        }
        return UIImage()
    }

}




