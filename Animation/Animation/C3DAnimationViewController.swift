//
//  C3DAnimationViewController.swift
//  Animation
//
//  Created by Sergio Ordine on 6/29/15.
//  Copyright (c) 2015 Sergio Ordine. All rights reserved.
//

import UIKit

class C3DAnimationViewController: UIViewController {
    
    var turn:Bool = false
    let imageName = "ironman"
    
    //Create the perspective effect, smaller values have more dramatic effects
    //while larger values makes the effect more flatter
    let eyePosition = CGFloat(400.0)
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var bottomImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: imageName)
        
        let topRect = CGRect(x: 0,y: 0,width: image!.size.width, height: image!.size.height/2.0)
        let bottomRect = CGRect(x: 0,y: image!.size.height/2.0,width: image!.size.width, height: image!.size.height/2.0)
        
        let topImg = CGImageCreateWithImageInRect(image!.CGImage, topRect);
        let bottomImg = CGImageCreateWithImageInRect(image!.CGImage, bottomRect);
        
        imageView.image = UIImage(CGImage:topImg)
        bottomImage.image = UIImage(CGImage:bottomImg)
        
        
        self.imageView.backgroundColor = UIColor(red: 0.85, green: 0.52, blue: 0.12, alpha: 0.7)
        
        
        imageView.layer.anchorPoint = CGPointMake(0.5,1.0)
    }
    
    
    override func viewDidLayoutSubviews() {
        imageView.layer.transform = CATransform3DMakeTranslation(0, imageView.layer.bounds.height/2.0, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    @IBAction func animate(sender: UIButton) {
        
        //Make rotation over all transformations already done
        var rotationAndPerspectiveTransform = imageView.layer.transform
        
        //Create the perspective effect. The m34 parameter changes the distance from 
        //the layer to the projection plane.
        //Reference: https://en.wikipedia.org/wiki/3D_projection#Perspective_projection
        rotationAndPerspectiveTransform.m34 = -1.0 / eyePosition
        
        if (!turn) {

            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, CGFloat(M_PI * 0.6), CGFloat(-1.0), CGFloat(0.0), CGFloat(0.0));
        } else {
             rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0));
        }
        
        rotateTopImage(rotationAndPerspectiveTransform)
        
        turn = !turn
    }
    
    //MARK: Auxiliary Methods
    
    func rotateTopImage(transform:CATransform3D) {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.duration = 1.0
        animation.toValue = NSValue(CATransform3D: transform)
        self.imageView.layer.addAnimation(animation, forKey: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
