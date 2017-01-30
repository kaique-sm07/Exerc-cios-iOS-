//
//  WordsTableViewController.swift
//  MobyDickWordCount
//
//  Created by Augusto Souza on 8/10/15.
//  Copyright (c) 2015 Augusto. All rights reserved.
//

import UIKit
import MBProgressHUD

class WordsTableViewController: UITableViewController {
    var words: [String: Int]?
    
    lazy var sortedWords: [String] = {
        if let words = self.words {
            return words.keys.array.sorted { $0 < $1}
        } else {
            return []
        }
    }()

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let wordCounter = WordCounter(resourceName: "moby_dick", resourceType: "txt")
        
//        words = wordCounter.execute()
  
  //      tableView.reloadData()
        
            MBProgressHUD.showHUDAddedTo(view, animated: true)
            wordCounter.executeAsync { (wordsAsync) -> Void in
                self.words = wordsAsync
            
            dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                }
            }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let words = self.words {
            return words.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        let w = sortedWords[indexPath.row]
        
        cell.textLabel?.text = "\"\(w)\""
        if let wordCount = words?[w] {
            cell.detailTextLabel?.text = "\(wordCount)"
        }

        return cell
    }
}
