//
//  FoodTruckViewController.swift
//  FoodTruckSimulator
//
//  Created by SERGIO J RAFAEL ORDINE on 8/9/15.
//  Copyright (c) 2015 Sergio Ordine. All rights reserved.
//

import UIKit

class FoodTruckViewController: UIViewController, UICollectionViewDataSource {
    
    
    // MARK: - Attributes
    var orderList:[Order] = [Order]()
    var ticketCounter:Int = 0
    
    var kitchenOperationCounter = 0
    var toyOperationCounter = 0
    var assembleOperationCounter = 0
    
    // TODO: - Queues
    
    var kitchenQueue = NSOperationQueue()
    var mainQueue = NSOperationQueue.mainQueue()
    var toyQueue = NSOperationQueue()
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var kitchenCounterLabel: UILabel!
    @IBOutlet weak var toyCounterLabel: UILabel!
    @IBOutlet weak var assembleCounterLabel: UILabel!
    
    @IBOutlet weak var kitchenActivity: UIActivityIndicatorView!
    @IBOutlet weak var toyActivity: UIActivityIndicatorView!
    @IBOutlet weak var assembleActivity: UIActivityIndicatorView!
    
    
    @IBOutlet weak var orderCollection: UICollectionView!
    
    
    // MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderCollection.dataSource = self
        //kitchenQueue.maxConcurrentOperationCount = 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func orderSandwich(sender: UIButton) {
        
        let type = SandwichType(rawValue: sender.tag)
        
        if let sandwichType = type {
          //  ticketCounter++
          //  let order = KitchenServices.prepareOrder(sandwichType, ticketNumber: ticketCounter)
          //  orderList.insert(order, atIndex: 0)
          //  orderCollection.reloadData()
            
            
            ticketCounter++
            
            kitchenOperationCounter++
            toyOperationCounter++
            assembleOperationCounter++
            
            updateOperationsOnUI()
            
            let prepare = KitchenOperation(type: sandwichType, number: ticketCounter,completion: {[unowned self]()->Void in
                self.kitchenOperationCounter--
                let update = NSBlockOperation(block: {[unowned self] () -> Void in
                    self.updateOperationsOnUI()
                })
                self.mainQueue.addOperation(update)
            })
            let toy = ToyOperation(completion: {[unowned self]()->Void in
                self.toyOperationCounter--
                let update = NSBlockOperation(block: {[unowned self] () -> Void in
                    self.updateOperationsOnUI()
                    })
                self.mainQueue.addOperation(update)
                })

            let assemble = AssembleOperation(completion:{ [unowned self] (order) -> Void in
                
                if order != nil {
                   self.orderList.insert(order, atIndex: 0)
                    self.assembleOperationCounter--
                    let deliver = NSBlockOperation(block: {[unowned self] () -> Void in
                        self.orderCollection.reloadData()
                        self.updateOperationsOnUI()
                    })
                    self.mainQueue.addOperation(deliver)
                }
            }
            )
            
            assemble.addDependency(toy)
            assemble.addDependency(prepare)
            
            kitchenQueue.addOperation(prepare)
            toyQueue.addOperation(toy)
            toyQueue.addOperation(assemble)
        }
        
    }
    
    
    // MARK: - Collection View Data Source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderList.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("sandwichCell", forIndexPath: indexPath) as! SandwichCell
        let order = orderList[indexPath.row]
        
        cell.sandwichImage.image = order.sandwichImage
        cell.counterLabel.text = "\(order.ticketNumber)"
        
        return cell
        
    }
    
    // MARK: - Auxiliary Methods
    
    ///
    /// Update the operation counters and activity indicators on the UI
    ///
    func updateOperationsOnUI() {
        self.updateLabels()
        self.updateIndicators()
    }
    
    /// Update counter labels
    func updateLabels() {
        kitchenCounterLabel.text = "\(kitchenOperationCounter)"
        toyCounterLabel.text = "\(toyOperationCounter)"
        assembleCounterLabel.text = "\(assembleOperationCounter)"
    }
    
    /// Update activity indicators status and animation
    func updateIndicators() {
        checkIndicator(kitchenActivity, counter: kitchenOperationCounter)
        checkIndicator(toyActivity, counter: toyOperationCounter)
        checkIndicator(assembleActivity, counter: assembleOperationCounter)
    }
    
    
    ///Check a given counter and update an activity indicator accordingly.
    /// if the counter is set to 0 the activity indicator is hidden
    ///
    ///:param: activityIndicator The activity indicator which will be updated.
    ///:param: counter The counter to be used
    func checkIndicator(activityIndicator: UIActivityIndicatorView ,counter:Int) {
        if (counter == 0) {
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
        }
    }
    


}
