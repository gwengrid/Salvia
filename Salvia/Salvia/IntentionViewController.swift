//
//  IntentionViewController.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/13/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit

class IntentionViewController: UIViewController {
    private let keeper: TaskKeeper

    let focus: Task?

    required init?(coder aDecoder: NSCoder) {
        fatalError("why are you here? in any case, here's a nice quote: If you just wake up wake up wake up wake up wake up wake up one day you’ll forget why.")
    }

    required init(keeper: TaskKeeper) {
        self.keeper = keeper
        self.focus = keeper.fetchNextInQueue()
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
