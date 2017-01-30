//
//  ViewController.swift
//  Cinco Bola
//
//  Created by Kaique de Souza Monteiro on 13/04/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell  = tableView.dequeueReusableCellWithIdentifier("testsIndentifier") as? Cell
        
        if (cell == nil) {
            cell = Cell(style: UITableViewCellStyle.Value1, reuseIdentifier: "testsIndentifier")
        }
        
        return changeCellContend(cell!, index: indexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as? Cell
        cell?.valueField.becomeFirstResponder()
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
    }


    func changeCellContend (cell: Cell, index: Int) ->Cell {
        if(index == 2) {
            cell.descriptionLabel.text = "Peso da ultima prova"
        } else if(index == 1) {
            cell.descriptionLabel.text = "Número de provas"
        }
        return cell
    }

}

