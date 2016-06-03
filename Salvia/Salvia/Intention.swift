//
//  Paradigm.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/11/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit
import Colours


enum Intention {
    case Setting
    case Doing
}

struct Layout {
    var intention: Intention {
        willSet {
            NSLayoutConstraint.deactivateConstraints(definingConstraints)
        }
        didSet {
            NSLayoutConstraint.activateConstraints(definingConstraints)
        }
    }

    let setting: [NSLayoutConstraint]
    let doing: [NSLayoutConstraint]

    init(intention:Intention, setting: [NSLayoutConstraint], doing: [NSLayoutConstraint]) {
        self.intention = intention
        self.setting = setting
        self.doing = doing
    }

    var definingConstraints: [NSLayoutConstraint] {
        switch intention {
        case .Setting:
            return setting
        case .Doing:
            return doing
        }
    }
    
    var taskTextEditable: Bool {
        return intention == .Setting ? true : false
    }

    var taskDateAlpha: CGFloat {
        return intention == .Doing ? 1 : 0
    }

    var taskDateText: String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter.stringFromDate(NSDate.today())
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


