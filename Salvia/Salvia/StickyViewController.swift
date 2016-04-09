//
//  StickyViewController.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/4/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit
import Colours

class StickyViewController: UIViewController, UIGestureRecognizerDelegate, UITextViewDelegate {
    var taskkeeper: TaskKeeper!

    var presentationState: StickyState = .Hiding {
        didSet {
//            let isHiding = self.presentationState == .Hiding
//            let stickyRemove = isHiding ? self.StickyPresentConstraints : self.StickyHidingConstraints
//            let stickyAdd = isHiding ? self.StickyHidingConstraints : self.StickyPresentConstraints
//            let buttonRemove = isHiding ? self.ButtonPresentConstraints : self.ButtonHidingConstraints
//            let buttonAdd = isHiding ? self.ButtonHidingConstraints : self.ButtonPresentConstraints
//
//            UIView.animateWithDuration(0.5) { () -> Void in
//                self.presentationStateChanged?(self.presentationState)
//                self.taskText.alpha = isHiding ? 0 : 1
//
//                self.stickyView.removeConstraints(stickyRemove)
//                self.addButton.removeConstraints(buttonRemove)
//
//                self.stickyView.addConstraints(stickyAdd)
//                self.addButton.addConstraints(buttonAdd)
//
//                self.stickyView.backgroundColor = self.stickyColours[0]
//                self.view.layoutIfNeeded()
//            }
        }
    }
    var presentationStateChanged:((StickyState) -> ())?
    let stickyColours = [UIColor(hex:"FFE56F"), UIColor(hex: "6FF2FF"), UIColor(hex: "FF87FB"), UIColor(hex: "93FF6F")]
    var stickyIndex = 0

    let placeholder = [
        "What do you want to do?",
        "Anything else?",
        "What's next?",
        "You got this, keep it coming!",
        "What else do you have?",
        "Lots of presence coming up for you!",
        "Awesome, do you have more?",
        "Baller, want to add more? 🏀",
        "Om nom nom nom. Delicious. Feed me. 🍇",
        "Sweet, let's tackle this together.",
        "Let's take on the world, you and me.",
        "Hustling everyday 👊",
        "I like that you're taking this one step a time.",
        "Your life is so full of upcoming adventures! 🌱",
        "Woo, give yourself some props!",
        "I got your back, friend. 👯",
    ]
    var quoteIndex = 0

    @IBOutlet weak var taskText: UITextView!
    
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

        let dismiss = UITapGestureRecognizer(target:self, action: Selector("dismiss:"))
        dismiss.delegate = self
        self.view.addGestureRecognizer(dismiss)

        self.taskText.delegate = self
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if (CGRectContainsPoint(self.stickyView.frame, touch.locationInView(self.stickyView))) {
                return false
        }
        return true
    }

    @IBAction func dismiss(sender: AnyObject) {
        self.taskText.resignFirstResponder()

        // if no task, hide
        // if there is task, arrive
//        self.presentationState = .Hiding
        self.presentationState = .Arrived
    }
    
    @IBAction func addSticky(sender: AnyObject) {
        if presentationState == .Input {
//            taskkeeper.saveNewTask(self.taskText.text)

            UIView.beginAnimations("Flip", context: nil)
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationTransition(.CurlUp, forView: self.stickyView, cache: true)
            UIView.commitAnimations()

            if ++stickyIndex == stickyColours.count {
                stickyIndex = 0
            }
            self.stickyView.backgroundColor = stickyColours[stickyIndex]

            if ++quoteIndex == placeholder.count {
                quoteIndex = 0
            }
            self.taskText.text = placeholder[quoteIndex]

        } else {
            self.taskText.text = "What do you want to do?"
            self.presentationState = .Input
        }
    }

    // MARK - uitextview delegate

    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
        UIView.animateWithDuration(0.5) { () -> Void in
            self.stickyView.transform = CGAffineTransformMakeTranslation(0, -100)
        }
    }

    func textViewDidEndEditing(textView: UITextView) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.stickyView.transform = CGAffineTransformIdentity
        }
    }
}


