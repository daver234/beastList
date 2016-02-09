//
//  ViewController.swift
//  beastList
//
//  Created by David Rothschild on 1/11/16.
//  Copyright © 2016 Dave Rothschild. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var insertTaskField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var tasks = Task.all()
    
    @IBAction func insertButtonPressed(sender: UIButton) {
        // insertTaskField.clearsOnBeginEditing = true
        // tasks.append(insertTaskField.text!)
        let task = Task(obj: insertTaskField.text!)
        task.save()
        print("here are tasks = \(tasks)")
        tasks = Task.all()
        // tableView.reloadData()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })

        //tableView.reloadData()
    
        insertTaskField.resignFirstResponder()
    }
    
    // var tasks = ["Exercise for 30 minutes", "Wireframe for some project", "Do laundry"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell")!
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        // cell.textLabel?.text = task
        cell.textLabel?.text = tasks[indexPath.row].objective
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Section: \(indexPath.section) and Row: \(indexPath.row)")
        tasks.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }

}

