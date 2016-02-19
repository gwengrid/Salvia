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
    var currentTask: Task!
    
    @IBOutlet weak var todayTaskLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var envelopeView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("present"))

        self.navigationController?.title = "Today's mission"
        self.envelopeView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.height)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        currentTask = taskKeeper?.fetchNextInQueue()
        todayTaskLabel.text = (currentTask != nil) ? currentTask!.task : "No mission today"
        todayTaskLabel.alpha = 0

        self.completionButton.hidden = (currentTask == nil)

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
        self.completionButton.hidden = true
        taskKeeper?.complete(currentTask)
        todayTaskLabel.text = "Good job!"
    }
}

