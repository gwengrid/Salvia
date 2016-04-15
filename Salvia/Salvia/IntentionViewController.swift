//
//  IntentionViewController.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/13/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit

typealias IntentChange = (Intention) -> ()

class IntentionViewController: UIViewController {
    private let keeper: TaskKeeper
    private var layout: Layout!
    private var intent: Intention = Intention.Being {
        didSet {
            UIView.animateWithDuration(0.5) { () -> Void in
                self.layout.intention = self.intent
                self.intentionChanged?(self.intent)

                self.today.alpha = self.layout.taskDateAlpha
                self.cancelButton.alpha = self.layout.cancelButtonAlpha
                self.settingButton.setImage(self.layout.actionButtonImage, forState: .Normal)
                
                self.view.layoutIfNeeded()
            }
        }
    }

    var intentionChanged:(IntentChange)?
    let focus: Task?

    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var space: UIView!
    @IBOutlet weak var today: UILabel!

    @IBOutlet var beingLayout: [NSLayoutConstraint]!
    @IBOutlet var settingLayout: [NSLayoutConstraint]!
    @IBOutlet var doingLayout: [NSLayoutConstraint]!

    required init?(coder aDecoder: NSCoder) {
        fatalError("If you just wake up wake up wake up wake up wake up wake up one day you’ll forget why.")
    }

    required init(keeper: TaskKeeper) {
        self.keeper = keeper
        self.focus = keeper.fetchNextInQueue()
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        layout = Layout(intention:intent,
            being:beingLayout,
            setting:settingLayout,
            doing:doingLayout)
        self.today.text = layout.taskDateText
    }

    @IBAction func settingAction(sender: AnyObject) {
        switch (intent){
        case .Being:
            intent = .Setting
        case .Doing:
            flip()
        default: break
        }
    }

    @IBAction func cancelAction(sender: AnyObject) {
        switch (intent){
        case .Being:
            intent = .Setting
        case .Doing:
            flip()
        default: break
        }

        intent = .Being
    }
}

extension IntentionViewController {
    func flip() {
        UIView.beginAnimations("Flip", context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationTransition(.CurlUp, forView: self.space, cache: true)
        self.space.removeFromSuperview()
        self.view.addSubview(self.space)
        UIView.commitAnimations()
    }
}
