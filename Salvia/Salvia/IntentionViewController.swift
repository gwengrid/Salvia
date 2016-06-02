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
    private var layout: Layout!
    var focus: Task? {
        didSet {
            if let todaysFocus = focus?.task {
                intention.text = todaysFocus
            }
        }
    }
    private var intent: Intention = .Setting {
        didSet {
            UIView.animateWithDuration(0.5) { () -> Void in
                self.layout.intention = self.intent

                self.today.alpha = self.layout.taskDateAlpha
                self.intention.editable = self.layout.taskTextEditable

                self.cancelButton.alpha = self.layout.cancelButtonAlpha
                self.settingButton.setImage(self.layout.actionButtonImage, forState: .Normal)
                self.settingButton.enabled = self.intent == .Setting ? false : true

                if self.intent != .Setting {
                    self.space.backgroundColor = self.layout.placeholderColours.array[0]
                }

                if self.intent == .Doing, let todaysFocus = self.focus {
                    self.intention.text = todaysFocus.task
                }
                self.view.layoutIfNeeded()
            }
        }
    }

    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var space: UIView!
    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var intention: UITextView!

    @IBOutlet var beingLayout: [NSLayoutConstraint]!
    @IBOutlet var settingLayout: [NSLayoutConstraint]!
    @IBOutlet var doingLayout: [NSLayoutConstraint]!

    required init?(coder aDecoder: NSCoder) {
        fatalError("If you just wake up wake up wake up wake up wake up wake up one day you’ll forget why.")
    }

    required init(keeper: TaskKeeper) {
        self.keeper = keeper
        self.focus = keeper.fetchTask(NSDate.today())
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        layout = Layout(intention:intent,
            setting:settingLayout,
            doing:doingLayout)

        self.today.text = layout.taskDateText
        self.intention.delegate = self
        if intent == .Setting {
            self.intention.text = "What's your next step?"
        }

        let dismiss = UITapGestureRecognizer(target:self, action: #selector(cancelAction))
        dismiss.delegate = self
        self.view.addGestureRecognizer(dismiss)
    }

    @IBAction func settingAction(sender: AnyObject) {
        switch (intent){
        case .Setting:
            keeper.saveNewTask(self.intention.text)

            self.space.backgroundColor = self.layout.placeholderColours.next()
            self.intention.text = ""
            self.settingButton.enabled = !self.intention.text.isEmpty

            flip()
        case .Doing:
            keeper.complete(self.focus!)
            self.focus = nil
            flip()
        }
    }

    @IBAction func cancelAction(sender: AnyObject) {
        if intent != .Setting {
            return
        }

        self.intention.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
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

    // MARK: gesture delegate

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if (CGRectContainsPoint(self.space.frame, touch.locationInView(self.space))) {
            return false
        }
        return true
    }
}

extension IntentionViewController {
    func flip() {
        UIView.beginAnimations("Flip", context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationTransition(.CurlUp, forView: self.space, cache: true)
        UIView.commitAnimations()
    }
}
