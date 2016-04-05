//
//  StickyViewController.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/4/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit

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
            UIView.setAnimationDuration(1.0)
            UIView.setAnimationTransition(.CurlUp, forView: self.stickyView, cache: true)
            UIView.commitAnimations()
        }

        self.presentationState = self.presentationState == .Hiding ? .Present : .Hiding
    }
}


