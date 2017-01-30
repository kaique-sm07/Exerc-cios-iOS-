//
//  CarometroTableViewController.swift
//  CarometroGravatar
//
//  Created by Augusto Souza on 8/11/15.
//  Copyright (c) 2015 Augusto. All rights reserved.
//

import UIKit

class CarometroTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmailCollection.emails.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        cell.textLabel?.text = EmailCollection.emails[indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.email = EmailCollection.emails[indexPath.row]
        }
    }
}
