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

    private let keeper: TaskKeeper

    required init?(coder aDecoder: NSCoder) {
        fatalError("There is nothing more beautiful than the way the ocean refuses to stop kissing th shoreline, no matter how many times it's sent away")
    }

    required init(keeper: TaskKeeper) {
        self.keeper = keeper
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        refresh()
    }

    override func viewDidAppear(animated: Bool) {
        let task = keeper.fetchTask(NSDate.today())
        let taskAvailable = task != nil && task?.wasCompletedToday() != true

        if taskAvailable {
            showInputMode()
        }
    }

    func refresh() {
        let task = keeper.fetchTask(NSDate.today())
        if task?.wasCompletedToday() == true {
            self.happyText.text = "You’ve done enough today, good job.  👏😊"
        }
        else if task == nil {
            self.happyText.text = "Nothing in your list. 😌✨"
        } else {
            self.happyText.text = ""
        }
    }

    @IBAction func showInputMode() {
        let intentionSpace = IntentionViewController(keeper: keeper)
        intentionSpace.modalTransitionStyle = .CoverVertical
        self.presentViewController(intentionSpace, animated: true, completion: nil)
    }
}
