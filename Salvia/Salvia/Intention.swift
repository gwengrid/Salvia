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
    static func taskTextEditable(intention: Intention) -> Bool {
        return intention == .Setting ? true : false
    }

    static func taskDateAlpha(intention: Intention) -> CGFloat {
        return intention == .Doing ? 1 : 0
    }

    static func taskDateText() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter.stringFromDate(NSDate.today())
    }

    static func cancelButtonAlpha(intention: Intention) -> CGFloat {
        return intention == .Setting ? 1 : 0
    }

    static func actionButtonImage(intention: Intention) -> UIImage {
        if let image = intention == .Doing ? UIImage(named: "CheckButton") : UIImage(named: "AddButton") {
            return image
        }
        return UIImage()
    }
}


