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
    
    @IBOutlet weak var todayTaskLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("present"))
        
        let task = taskKeeper?.fetchNextInQueue()
        todayTaskLabel.text = (task != nil) ? task!.task : "No mission today"
    }

    func present() {
        let newTaskVC = NewTaskViewController(nibName: "NewTask", bundle: nil)
        newTaskVC.taskkeeper = taskKeeper
        self.navigationController?.pushViewController(newTaskVC, animated: true)
    }

    @IBAction func missionSuccess(sender: AnyObject) {
        
    }
}

