//
//  TaskViewController.swift
//  Salvia
//
//  Created by Gwendolyn on 1/20/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit

class TaskViewController: UITableViewController {

    let cellIdentifier = "AVeryMerryCellIdentifierCheerio"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:cellIdentifier)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        if let label = cell.textLabel  {
            label.text = "Something adorable"
        }
        return cell
    }
}
