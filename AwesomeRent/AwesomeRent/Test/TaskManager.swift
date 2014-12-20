//
//  TaskManager.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/17/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit

var taskMgr : TaskManager = TaskManager()

struct task {
    var name = "Un-Named"
    var desc = "Un_Described"
}

class TaskManager: NSObject {
   var tasks = [task]()

    func addTask(name: String, desc: String) {
        tasks.append(task(name: name, desc: desc))
    }
    
    
}
