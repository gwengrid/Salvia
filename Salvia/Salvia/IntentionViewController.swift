//
//  IntentionViewController.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/13/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit
import EasyAnimation

class IntentionViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {
    private let keeper: TaskKeeper
    var focus: Task? {
        didSet {
            if let todaysFocus = focus?.task {
                self.intent = .Doing
                intention.text = todaysFocus
            }
        }
    }
    private var intent: Intention = .Setting {
        willSet {
            NSLayoutConstraint.deactivateConstraints(definingConstraints(intent))
        }
        didSet {
            NSLayoutConstraint.activateConstraints(definingConstraints(intent))
            self.format(intent)
        }
    }

    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var space: UIView!
    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var intention: UITextView!

    @IBOutlet var settingLayout: [NSLayoutConstraint]!
    @IBOutlet var doingLayout: [NSLayoutConstraint]!

    required init?(coder aDecoder: NSCoder) {
        fatalError("If you just wake up wake up wake up wake up wake up wake up one day you’ll forget why.")
    }

    required init(keeper: TaskKeeper) {
        self.keeper = keeper
        let task = keeper.fetchTask(NSDate.today())
        self.focus = task?.wasCompletedToday() == true ? nil : task
        self.intent = self.focus != nil ? .Doing : .Setting
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // view initilization
        self.today.text = Layout.taskDateText()
        self.intention.delegate = self

        self.format(self.intent)
    }

    override func viewWillAppear(animated: Bool) {
        if intent == .Setting {
            self.intention.text = "What's your next step?"
        }
        self.settingButton.enabled = self.intent == .Setting ? false : true
    }

    func definingConstraints(intention: Intention) -> [NSLayoutConstraint] {
        switch intention {
        case .Setting:
            return settingLayout
        case .Doing:
            return doingLayout
        }
    }

    func format(intention:Intention) {
        UIView.animateWithDuration(0.5) { () -> Void in

            self.today.alpha = Layout.taskDateAlpha(self.intent)
            self.intention.editable = Layout.taskTextEditable(self.intent)
            self.cancelButton.alpha = Layout.cancelButtonAlpha(self.intent)
            self.settingButton.setImage(Layout.actionButtonImage(self.intent), forState: .Normal)
            self.settingButton.enabled = self.intent == .Setting ? false : true

            if self.intent == .Doing, let todaysFocus = self.focus {
                self.intention.text = todaysFocus.task
            }
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func settingAction(sender: AnyObject) {
        switch (intent){
        case .Setting:
            keeper.saveNewTask(self.intention.text)

            self.intention.text = ""
            self.settingButton.enabled = false
            UIView.transitionWithView(self.space, duration: 0.5, options: [.TransitionCurlUp], animations: nil, completion: nil)

        case .Doing:
            keeper.complete(self.focus!)
            UIView.transitionWithView(self.space, duration: 0.5, options: [.TransitionCurlUp], animations: { 
                self.intention.text = ""
                }, completion: { (flag) in
                    self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }

    @IBAction func cancelAction(sender: AnyObject) {
        if intent != .Setting {
            return
        }

        self.intention.resignFirstResponder()
        let possibleNewTask = keeper.fetchTask(NSDate.today())

        if possibleNewTask != nil && possibleNewTask?.wasCompletedToday() != true {
            self.focus = possibleNewTask
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    // MARK: uitextview delegate

    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
        UIView.animateWithDuration(0.5) { () -> Void in
            self.space.transform = CGAffineTransformMakeTranslation(0, -100)
        }
    }

    func textViewDidEndEditing(textView: UITextView) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.space.transform = CGAffineTransformIdentity
        }
    }

    func textViewDidChange(textView: UITextView) {
        self.settingButton.enabled = !textView.text.isEmpty
    }
}
