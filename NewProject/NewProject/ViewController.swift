//
//  ViewController.swift
//  NewProject
//
//  Created by Marcelo Reina on 30/06/15.
//  Copyright (c) 2015 BEPiD 2015. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //get the localized name of the image from xcassets
        let localizedImageName = NSLocalizedString("usFlag", comment:"name of the flag image on xcassets")
        flagImageView.image = UIImage(named: localizedImageName)
        
        //Format the date to set the label text
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let dateStringFormat = NSLocalizedString("Today is %@", comment: "date string for today")
        let dateStringFromDateFormatter = dateFormatter.stringFromDate(NSDate())
        dateLabel.text = String(format: dateStringFormat, arguments: [dateStringFromDateFormatter])
        
        //format the value as currency to set the label text
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1
        
        let valueFormat = NSLocalizedString("Value: %@", comment:"value string")
        let valueFromFormatter = numberFormatter.stringFromNumber(NSNumber(double: 300.444))
        valueLabel.text = String(format: valueFormat, arguments: [valueFromFormatter!])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

