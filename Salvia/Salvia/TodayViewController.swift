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
            if todayState == TodayState.Present, let taskDescription = currentTask?.task {
                todayTaskLabel.text = taskDescription
            } else {
                todayTaskLabel.text = todayState.defaultString
            }
        }
    }
    
    @IBOutlet weak var peekingView: UIView!
    @IBOutlet weak var todayTaskLabel: UILabel!
    @IBOutlet weak var happyFaceView: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("Sticky") as? StickyViewController
        if let childVC = vc {
            self.addChildViewController(childVC)
            self.view.addSubview(childVC.view)

            childVC.view.transform = CGAffineTransformMakeTranslation(0, 450)
            childVC.didMoveToParentViewController(self)

            childVC.presentationStateChanged = { (state:StickyState) in
                let transform: CGAffineTransform
                switch state{
                case .Present:
                    transform = CGAffineTransformIdentity
                    break
                case .Hiding:
                    transform = CGAffineTransformMakeTranslation(0, 450)
                    break
                }
                childVC.view.transform = transform
            }
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        currentTask = taskKeeper?.fetchNextInQueue()

        UIView.animateWithDuration(1, delay:0, options: [.CurveEaseInOut, .Autoreverse, .Repeat], animations: { () -> Void in
            self.happyFaceView.transform = CGAffineTransformMakeTranslation(0, 5)
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

