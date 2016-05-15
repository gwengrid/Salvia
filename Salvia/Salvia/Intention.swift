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
    case Being
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

    let being: [NSLayoutConstraint]
    let setting: [NSLayoutConstraint]
    let doing: [NSLayoutConstraint]

    init(intention:Intention, being: [NSLayoutConstraint], setting: [NSLayoutConstraint], doing: [NSLayoutConstraint]) {
        self.intention = intention
        self.being = being
        self.setting = setting
        self.doing = doing
    }

    var definingConstraints: [NSLayoutConstraint] {
        switch intention {
        case .Being:
            return being
        case .Setting:
            return setting
        case .Doing:
            return doing
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

    var taskDateText: String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter.stringFromDate(NSDate.today()!)
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

    var placeholderColours = Cycle(array: [UIColor(hex:"FFE56F"), UIColor(hex: "6FF2FF"), UIColor(hex: "FF87FB"), UIColor(hex: "93FF6F")]
    )
}

struct Cycle<T> {
    let array: Array<T>
    var index: Int

    init(array:Array<T>) {
        self.array = array
        self.index = 0
    }

    mutating func next() -> T {
        if ++index == array.endIndex {
            index = 0
        }
        return self.array[index] as T
    }
}



