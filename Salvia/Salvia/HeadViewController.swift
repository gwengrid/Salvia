//
//  HeadViewController.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/13/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit

class HeadViewController: UIViewController {

    @IBOutlet weak var happyText: UILabel!

    private let intentionSpace: IntentionViewController
    private let keeper: TaskKeeper

    var headstate: Headstate = .Empty {
        didSet {
            self.happyText.text = headstate == .Enough ? "You’ve done enough today, good job.  👏😊" : "Nothing in your list. 😌✨"
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("There is nothing more beautiful than the way the ocean refuses to stop kissing th shoreline, no matter how many times it's sent away")
    }

    required init(intent: IntentionViewController, keeper: TaskKeeper) {
        self.intentionSpace = intent
        self.keeper = keeper
        super.init(nibName: nil, bundle: nil)

        self.addChildViewController(self.intentionSpace)
        self.view.addSubview(self.intentionSpace.view)
        self.intentionSpace.didMoveToParentViewController(self)
        
        self.intentionSpace.intentionChanged = { (intent: Intention) in
            self.intentionSpace.view.transform = intent == .Being ? CGAffineTransformMakeTranslation(0, 450) : CGAffineTransformIdentity
            self.happyText.alpha = intent == .Being ? 1 : 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }

    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refresh), name: NewIntentionNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refresh), name: IntentFulfilledNotification, object: nil)
    }

    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func refresh() {
        let task = keeper.fetchNextInQueue()
        if task?.wasCompletedToday() == true {
            self.headstate = .Enough
        }
        else if task == nil {
            self.headstate = .Empty
        }

    }
}
