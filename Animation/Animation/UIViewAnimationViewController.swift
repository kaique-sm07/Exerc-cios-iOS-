//
//  UIViewAnimationViewController.swift
//  Animation
//
//  Created by Sergio Ordine on 6/29/15.
//  Copyright (c) 2015 Sergio Ordine. All rights reserved.
//

import UIKit

class UIViewAnimationViewController: UIViewController {

    let imageName = "ironman"
    let minimumPosition = CGFloat(40.0)
    let maximumPosition = CGFloat(300.0)
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toastedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named:imageName)
        imageView.image = image
        
        self.toastedButton.transform = CGAffineTransformMakeScale(0, 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    @IBAction func reset(sender: UIButton) {
        let image = UIImage(named:imageName)
        imageView.image = image
    }
    
    @IBAction func toast(sender: UIButton) {
        UIView.animateWithDuration(1.0, animations: { () -> Void in self.topConstraint.constant = self.maximumPosition
            self.view.layoutIfNeeded()}, completion: {(result)-> Void in
                self.toastMyImage(self.imageName, completion: {(image) -> Void in
                    self.imageView.image = image
                    
                    
                    UIView.animateKeyframesWithDuration(2.0, delay: 0, options: nil, animations: {() -> Void in
                        
                            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.6, animations: {() -> Void in
                                    self.toastedButton.transform = CGAffineTransformMakeScale(1.3, 1.3)})
                        
                            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.4, animations: {() -> Void in
                            self.toastedButton.transform = CGAffineTransformMakeScale(1.0, 1.0)})
                        },
                        
                        
                        completion: {(result) -> Void in})
                    
                    
                   /* UIView.animateWithDuration(1.0, animations: {() -> Void in
                        
                        self.toastedButton.transform = CGAffineTransformMakeScale(1.3, 1.3)
                        
                        }, completion: {(completion) -> Void in
                            UIView.animateWithDuration(0.3, animations: {() -> Void in self.toastedButton.transform = CGAffineTransformMakeScale(1.0, 1.0)})
                    })*/
                })
                
                
        })
    }
    
    @IBAction func toasted(sender: UIButton) {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.8, options: nil, animations: {() -> Void in
                self.topConstraint.constant = self.minimumPosition
            self.imageView.layoutIfNeeded()
            }, completion: {(result) -> Void in
                UIView.animateWithDuration(0.3, animations: {() -> Void in
                    self.toastedButton.transform = CGAffineTransformMakeScale(0.1, 0.1)
                    }, completion: {(result) -> Void in
                        self.toastedButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
                })
        })

    }
    

    
    ///MARK: Auxiliary Methods
    
    
    func toastMyImage(imageName:String, completion:(UIImage!) -> Void) {
        //Run the image convertion assynchronously
        let queue = NSOperationQueue()
        let block = NSBlockOperation { () -> Void in
            let image = UIImage(named:imageName)
            let startImage = CIImage(CGImage: image?.CGImage)
            let context = CIContext(options: nil)
            
            //Generate a sepia filter and apply to the selected image
            let filter = CIFilter(name: "CISepiaTone", withInputParameters: [kCIInputImageKey:startImage,"inputIntensity":0.8])
            //Get converted image
            let outputImage = filter.outputImage
            
            //Use the CI (Core Image) context to generate a CG Image
            let cgImage = context.createCGImage(outputImage, fromRect: outputImage.extent())
            
            
            //Create the UIKit image based on the CG Image
            //This convertion is done due to performance and managing resources
            //not available when UIImage is created directly from CIImage
            let finalImage = UIImage(CGImage: cgImage)
            
            //Execute the completion block on the main thread (UI thread)
            let mainQueue = NSOperationQueue.mainQueue()
            let completionBlock = NSBlockOperation(block: { () -> Void in
                completion(finalImage)
            })
            mainQueue.addOperation(completionBlock)
        }
        
        queue.addOperation(block)
    }
    

}
