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
    typealias Layout = StickyLayout
    typealias Paradigm = StickyParadigm

    var taskkeeper: TaskKeeper!
    var currentTask: Task?

    var layout: Layout!

    var paradigm: Paradigm = .Ease {
        didSet {
            layout.paradigm = paradigm

            UIView.animateWithDuration(0.5) { () -> Void in
                self.paradigmChanged?(self.paradigm)
                self.taskText.alpha = self.layout.taskTextAlpha
                self.taskText.editable = self.layout.taskTextEditable
                self.taskDate.alpha = self.layout.taskDateAlpha
                self.cancelButton.alpha = self.layout.cancelButtonAlpha
                
                self.stickyView.backgroundColor = self.stickyColours[0]
                self.view.layoutIfNeeded()
            }
        }
    }
    var paradigmChanged:((Paradigm) -> ())?
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
    @IBOutlet weak var taskDate: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var stickyView: UIView!

    @IBOutlet var easeConstraints: [NSLayoutConstraint]!
    @IBOutlet var intentionConstraints: [NSLayoutConstraint]!

    required init?(coder aDecoder: NSCoder) {
        paradigmChanged = nil
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout = Layout(paradigm:paradigm,
            easeConstraints: easeConstraints,
            intentionConstraints:intentionConstraints,
            arrivedConstraints:intentionConstraints)

        self.view.backgroundColor = UIColor.clearColor()
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        self.taskDate.text = formatter.stringFromDate(NSDate.today()!)

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
        self.paradigm = currentTask ? .Arrived : .Ease
    }
    
    @IBAction func addSticky(sender: AnyObject) {
        if paradigm == .Intention {
            self.paradigm = .Arrived
//            taskkeeper.saveNewTask(self.taskText.text)

//            UIView.beginAnimations("Flip", context: nil)
//            UIView.setAnimationDuration(0.5)
//            UIView.setAnimationTransition(.CurlUp, forView: self.stickyView, cache: true)
//            UIView.commitAnimations()
//
//            if ++stickyIndex == stickyColours.count {
//                stickyIndex = 0
//            }
//            self.stickyView.backgroundColor = stickyColours[stickyIndex]
//
//            if ++quoteIndex == placeholder.count {
//                quoteIndex = 0
//            }
//            self.taskText.text = placeholder[quoteIndex]

        } else {
            self.taskText.text = "What do you want to do?"
            self.paradigm = .Intention
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
