//
//  NewTaskView.swift
//  Salvia
//
//  Created by gwendolyn weston on 2/11/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import Foundation
import UIKit

class NewTaskViewController: UIViewController {
    @IBOutlet weak var taskInput: UITextView!

    @IBOutlet var subview: UIView!
    var taskkeeper: TaskKeeper!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        subview = UIView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Mission Memo"
        self.edgesForExtendedLayout = .None
        let views = ["topGuide": self.topLayoutGuide, "view": self.view]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topGuide][view]", options: [], metrics: nil, views: views as! [String : AnyObject]))

        let tap = UITapGestureRecognizer(target: self, action: Selector("dismiss"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    func dismiss() {
        self.taskInput.endEditing(true)
    }

    @IBAction func saveNewTask(sender: AnyObject) {
        taskkeeper.saveNewTask(self.taskInput.text)
        self.navigationController?.popViewControllerAnimated(true)
    }
}

