//
//  DetailViewController.swift
//  CarometroGravatar
//
//  Created by Augusto Souza on 8/11/15.
//  Copyright (c) 2015 Augusto. All rights reserved.
//

import UIKit
import MBProgressHUD

class DetailViewController: UIViewController {
    var email: String!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var gravatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        let gravatarRequest = GravatarRequest()
        gravatarRequest.fetchProfile(email, completionHandler: { (username, image) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.usernameLabel.text = username
                self.gravatarImageView.image = image
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
