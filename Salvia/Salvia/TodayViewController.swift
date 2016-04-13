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
    let childVC: StickyViewController
    var currentTask: Task? {
        didSet {
            todayState = TodayState(task: currentTask)
        }
    }
    var headspace: Headspace! {
        didSet {
            todayTaskLabel.text = headspace.defaultString
            if let image = headspace.defaultImage {
                self.happyFaceView.image = image
            }

            let transform = headspace == Headspace.Available ?  CGAffineTransformMakeTranslation(0, 450) : CGAffineTransformIdentity
            let opacity = headspace == Headspace.Available ?  0 : 1

            childVC.view.transform = transform
            self.todayTaskLabel.alpha = opacity
            self.happyFaceView.alpha = opacity
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
            childVC.taskkeeper = taskKeeper

            childVC.paradigmChanged = { (state:StickyParadigm) in

                let transform: CGAffineTransform
                let opacity: CGFloat
                switch state{
                case .Intention:
                    transform = CGAffineTransformIdentity
                    opacity = 0
                    break
                case .Ease:
                    transform = CGAffineTransformMakeTranslation(0, 450)
                    opacity = 1
                    break
                case .Arrived:
                    return
                }

                childVC.view.transform = transform
                self.todayTaskLabel.alpha = opacity
                self.happyFaceView.alpha = opacity

            }
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)


        UIView.animateWithDuration(1, delay:0, options: [.CurveEaseInOut, .Autoreverse, .Repeat], animations: { () -> Void in
            self.happyFaceView.transform = CGAffineTransformMakeTranslation(0, 5)
        }, completion: nil)
    }

    @IBAction func missionSuccess(sender: AnyObject) {
        if currentTask != nil {
            taskKeeper?.complete(currentTask!)
            todayState = TodayState.Completed
        }
    }

}

