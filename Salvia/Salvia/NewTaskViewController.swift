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
    @IBOutlet weak var dueDateInput: UIDatePicker!
    
    @IBOutlet var subview: UIView!
    
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
    }
}

