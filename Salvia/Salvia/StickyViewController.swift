//
//  StickyViewController.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/4/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit
import Colours

enum StickyState {
    case Hiding
    case Present
}

class StickyViewController: UIViewController {
    var presentationState: StickyState = .Hiding {
        didSet {
            let isHiding = self.presentationState == .Hiding
            let stickyRemove = isHiding ? self.StickyPresentConstraints : self.StickyHidingConstraints
            let stickyAdd = isHiding ? self.StickyHidingConstraints : self.StickyPresentConstraints
            let buttonRemove = isHiding ? self.ButtonPresentConstraints : self.ButtonHidingConstraints
            let buttonAdd = isHiding ? self.ButtonHidingConstraints : self.ButtonPresentConstraints


            UIView.animateWithDuration(0.5) { () -> Void in
                self.presentationStateChanged?(self.presentationState)

                self.stickyView.removeConstraints(stickyRemove)
                self.addButton.removeConstraints(buttonRemove)

                self.stickyView.addConstraints(stickyAdd)
                self.addButton.addConstraints(buttonAdd)
                self.view.layoutIfNeeded()
            }
        }
    }
    var presentationStateChanged:((StickyState) -> ())?
    let stickyColours: [UIColor] = [UIColor(hex:"FFE56F"), UIColor(hex: "6FF2FF"), UIColor(hex: "FF87FB"), UIColor(hex: "93FF6F")]
    var stickyIndex = 0

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var stickyView: UIView!
    @IBOutlet var StickyPresentConstraints: [NSLayoutConstraint]!
    @IBOutlet var StickyHidingConstraints: [NSLayoutConstraint]!

    @IBOutlet var ButtonPresentConstraints: [NSLayoutConstraint]!
    @IBOutlet var ButtonHidingConstraints: [NSLayoutConstraint]!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presentationStateChanged = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        self.addButton.clipsToBounds = false
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.presentationState = .Hiding
    }
    
    @IBAction func addSticky(sender: AnyObject) {
        if presentationState == .Present {
            UIView.beginAnimations("Flip", context: nil)
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationTransition(.CurlUp, forView: self.stickyView, cache: true)
            UIView.commitAnimations()

            if ++stickyIndex == stickyColours.count {
                stickyIndex = 0
            }

            self.stickyView.backgroundColor = stickyColours[stickyIndex]

        } else {
            self.presentationState = self.presentationState == .Hiding ? .Present : .Hiding
        }

    }
}


