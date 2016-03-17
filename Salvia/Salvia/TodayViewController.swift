//
//  ViewController.swift
//  Salvia
//
//  Created by gwendolyn weston on 1/20/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    var taskKeeper: TaskKeeper?
    var currentTask: Task? {
        didSet {
            todayState = TodayState(task: currentTask)
        }
    }
    var todayState: TodayState! {
        didSet {
            completionButton.hidden = todayState.completionButtonState()
            if todayState == TodayState.Present, let taskDescription = currentTask?.task {
                todayTaskLabel.text = taskDescription
            } else {
                todayTaskLabel.text = todayState.defaultString()
            }
        }
    }
    
    @IBOutlet weak var todayTaskLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var envelopeView: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("present"))
        self.title = "Today's mission"
        let backButton = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        self.envelopeView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.height)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        currentTask = taskKeeper?.fetchNextInQueue()

        todayTaskLabel.alpha = 0
        UIView.animateWithDuration(2, delay:0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [.CurveEaseInOut], animations: { () -> Void in
            self.envelopeView.transform = CGAffineTransformIdentity
            self.todayTaskLabel.alpha = 1

        }, completion: nil)
    }

    func present() {
        let newTaskVC = NewTaskViewController(nibName: "NewTask", bundle: nil)
        newTaskVC.taskkeeper = taskKeeper
        self.navigationController?.pushViewController(newTaskVC, animated: true)
    }

    @IBAction func missionSuccess(sender: AnyObject) {
        if currentTask != nil {
            taskKeeper?.complete(currentTask!)
            todayState = TodayState.Completed
        }
    }
}

