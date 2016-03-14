//
//  TodayViewModel.swift
//  Salvia
//
//  Created by gwendolyn weston on 3/9/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import Foundation

struct TodayVM {
    let todayTask: String?
    let completionButtonHidden: Bool

    init(task:Task?) {
        self.todayTask = (task != nil) ? task!.task : "Nothing today.  Treat yourself!"
        self.completionButtonHidden = (task == nil)
    }
}