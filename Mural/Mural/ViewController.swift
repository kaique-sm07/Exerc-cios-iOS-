//
//  ViewController.swift
//  Mural
//
//  Created by Kaique de Souza Monteiro on 12/08/15.
//  Copyright (c) 2015 Kaique de Souza Monteiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mainQueue = NSOperationQueue.mainQueue()
    var images:[UIImage] = [UIImage]()

    @IBOutlet weak var photoCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        InstagramRequest.getPhotos({(images) -> Void in
           
            self.images = images
            let update = NSBlockOperation(block: {[unowned self] () -> Void in
                self.photoCollection.reloadData()
                })
            self.mainQueue.addOperation(update)
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellReuseIdentifier = "photoCell"
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! PhotoCell
        cell.photoImage.image = images[indexPath.row]
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 6
        
        return cell
    }



}

