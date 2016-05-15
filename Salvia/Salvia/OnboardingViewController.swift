//
//  OnboardingViewController.swift
//  Presence
//
//  Created by gwendolyn weston on 5/9/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit
import EasyAnimation

class OnboardingViewController: UIViewController {

    let onboarding = ["Sometimes, life piles up on us. It can be hard to start catching up. 😵", "If you’re feeling overwhelmed by your tasks or ashamed that you let this happen, just pause.\n\nTake a breath. Be kind to yourself. 😌💜", "It’s okay. You’re doing fine. 👏☺️\n\nLet’s just take this one item at a time.", "Really, just the one.☝️ You don’t see what’s coming up, so you don’t need to think about optimizing any plans or juggling different things.\n\nAll it takes is a little bit of presence every day.✨"]
    var index = 0

    @IBOutlet weak var onboardingView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onboardingView.text = onboarding[index]
        self.onboardingView.selectable = false

        let tap = UITapGestureRecognizer(target: self, action: #selector(forwards))
        self.view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func forwards() {
        index += 1
        UIView.animateAndChainWithDuration(0.8, delay: 0.0,
            options: [], animations: {
                self.onboardingView.alpha = 0
            }, completion: nil).animateWithDuration(0.8, animations: {
                if self.index == self.onboarding.count {
                    self.navigationController?.popViewControllerAnimated(false)
                } else {
                    self.onboardingView.text = self.onboarding[self.index]
                    self.onboardingView.alpha = 1
                }
            })
    }
}
