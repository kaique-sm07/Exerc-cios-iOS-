//
//  RPGViewController.swift
//  RPG
//
//  Created by SERGIO J RAFAEL ORDINE on 5/27/15.
//  Copyright (c) 2015 SERGIO J RAFAEL ORDINE. All rights reserved.
//

import UIKit

class RPGViewController: UIViewController, BattleProtocol {
    
    // MARK: - Constants
    let ITEM_SCALE_UP:CGFloat = 1.5
    let ITEM_SCALE_DOWN:CGFloat = 1.0
    
    let HP_SCALE_UP:CGFloat = 2.5
    let HP_SCALE_DOWN:CGFloat = 1.0
    let HP_SCALE_DOWN_MIN:CGFloat = 0.2
    
    
    let NO_ACTION_IMAGE_NAME = "no_action"
    let MELEE_ACTION_IMAGE_NAME = "melee_action"
    let HAND_FIGHT_ACTION_IMAGE_NAME = "hand_action"
    let UNDEFINED_ACTION_IMAGE_NAME = "undefined_action"
    
    // MARK: - Attributes

    @IBOutlet var itemViews: [UIImageView]!
    @IBOutlet weak var weaponSlot: UIImageView!
    @IBOutlet weak var amuletSlot: UIImageView!
    
    @IBOutlet var actionListViews: [UIImageView]!
    
    @IBOutlet weak var handFightButton: UIImageView!
    @IBOutlet weak var meleeFightButton: UIImageView!
    @IBOutlet weak var noActionButton: UIImageView!
    
    @IBOutlet weak var attack: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    
    
    @IBOutlet weak var hitPointsLabel: UILabel!
    
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var probabilityLabel: UILabel!
    
    
    var currentCommand:Int = 0
    
    
    var currentItemView:UIImageView!
    var commandList = [BattleCommand]()
    var character:Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add the item dragging view
        currentItemView = UIImageView(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        currentItemView.contentMode = .ScaleAspectFit
        self.view.addSubview(currentItemView)
        
        //Drag & Drop gesture recognizer
        let pan = UIPanGestureRecognizer(target: self, action: Selector("dragItem:"))
        self.view.addGestureRecognizer(pan)
        
        
        //Setup - character and action list
        currentCommand = -1
        createCharacter()
        
        for action in actionListViews {
            action.tintColor = UIColor.notEnabledColor()
        }
        
        
        //Set the tap gesture recognizer for action buttons
        handFightButton.tintColor = UIColor.handFightColor()
        meleeFightButton.tintColor = UIColor.meleeFightColor()
        noActionButton.tintColor = UIColor.noActionColor()
        
        let handFightTap = UITapGestureRecognizer(target: self, action: Selector("addAction:"))
        let meleeFightTap = UITapGestureRecognizer(target: self, action: Selector("addAction:"))
        let noActionTap = UITapGestureRecognizer(target: self, action: Selector("addAction:"))
        
        handFightButton.addGestureRecognizer(handFightTap)
        meleeFightButton.addGestureRecognizer(meleeFightTap)
        noActionButton.addGestureRecognizer(noActionTap)
    }
    
    
    func createCharacter()  {
        
        let factory = CharacterFactory()
        
        character = factory.createCharacter(self.weaponSlot.tag)
        character = factory.createCharacter(character, item: self.amuletSlot.tag)
        
        updateCharacterData()
        
    }
    
    // MARK: - Update UI elements
    
    func updateCharacterData() {
        damageLabel.text = String(stringInterpolationSegment: character.meleeDamage())
        probabilityLabel.text = String(stringInterpolationSegment: character.chanceOfSuccess())
    }
    
    func updateCommands() {
        
        for actionView in actionListViews {
            
            var image:UIImage! = UIImage(named:UNDEFINED_ACTION_IMAGE_NAME)
            
            let tag = actionView.tag
            
            if tag < commandList.count {

                let commandId = commandList[tag].commandId()
                
                switch commandId {
                case 1:
                    image = UIImage(named:HAND_FIGHT_ACTION_IMAGE_NAME)
                case 2:
                    image = UIImage(named:MELEE_ACTION_IMAGE_NAME)
                case 3:
                    image = UIImage(named:NO_ACTION_IMAGE_NAME)
                default:
                    break
                }
                
                actionView.image = image
                
            } else {
                actionView.image = image
            }
        }
    }
    
    // MARK: - Button Actions
    
  
    @IBAction func attack(sender: UIButton) {
        
        if currentCommand < commandList.count {
            
            sender.enabled = false
            self.undoButton.enabled = true
            
            if currentCommand == -1 {
                currentCommand = 0
            }
            
            
                let command = commandList[currentCommand]
                    
                var currentAction:UIImageView!
                    
                for action in actionListViews {
                    if action.tag == currentCommand {
                        currentAction = action
                        action.tintColor = UIColor.executingActionColor()
                    }
                }
                    
                command.execute({ () -> Void in
                        sender.enabled = true
                        currentAction.tintColor = UIColor.executedActionColor()
                        self.currentCommand++
                    })
        }
    }
    

    
   
    @IBAction func undoAction(sender: UIButton) {
        
        
        sender.enabled = false
        
        self.attack.enabled = true
        
        if currentCommand > 0 {
            
            self.currentCommand--
            
            
            let command = commandList[currentCommand]
            
            var currentAction:UIImageView!
            
            for action in actionListViews {
                if action.tag == currentCommand {
                    currentAction = action
                    action.tintColor = UIColor.executingUndoColor()
                }
            }
            
            command.undo({ () -> Void in
                self.commandList.removeLast()
                currentAction.image = UIImage(named:self.UNDEFINED_ACTION_IMAGE_NAME)
                currentAction.tintColor = UIColor.notEnabledColor()
                if self.currentCommand > -1 {
                    sender.enabled = true
                }
            })
        }
        
    }
    
    
    // MARK: - Gesture Recognition methods
    
    
    func addAction(tap:UITapGestureRecognizer) {
        let commandId = (tap.view?.tag)!
        
        let factory = CommandFactory()
        let command = factory.createCommand(commandId)
        
        command.delegate = self
        
        if (commandList.count < 5) {
            commandList.append(command)
            updateCommands()
        }
        
    }
    
    func dragItem(pan:UIPanGestureRecognizer) {
        
        var panImageView:UIImageView! = nil
        

        
        if (pan.state == .Began) {
            pan.setTranslation(CGPointZero, inView: self.view)
            
            currentItemView.backgroundColor = UIColor.clearColor()
            
            let position = pan.locationInView(self.view)

            let panImageView = itemForPosition(position)

            if panImageView != nil  {
                
                createDragIconView(panImageView)
                
            }
        }
        
        
        if (pan.state == .Changed) {
            let translation = pan.translationInView(self.view)
            
            currentItemView.transform = CGAffineTransformTranslate(currentItemView.transform, translation.x, translation.y)

            pan.setTranslation(CGPointZero, inView: self.view)
        }
        
        if (pan.state == .Ended) {
            
            //Adjust drag view center
            
            let position = pan.locationInView(self.view)
            let x = currentItemView.frame.origin.x + (currentItemView.frame.width / 2.0)
            let y = currentItemView.frame.origin.y + (currentItemView.frame.height / 2.0)
            
            currentItemView.center = CGPoint(x: x,y: y)
            currentItemView.transform = CGAffineTransformMakeScale(1.5, 1.5)
            
            //Prepare the drop item process
            
            var fadeOutAnimation:(()->Void)!
            var fadeInAnimation:(()->Void)!
            var validDrop = false
            var finalView:UIImageView! = nil
            
            if CGRectIntersectsRect(self.currentItemView.frame, self.weaponSlot.frame) {
                fadeInAnimation = fadeInWeapon
                fadeOutAnimation = fadeOutWeapon
                validDrop = itemIsAWeapon(self.currentItemView.tag)
                finalView = self.weaponSlot
            }
            
            if CGRectIntersectsRect(self.currentItemView.frame, self.amuletSlot.frame) {
                fadeInAnimation = fadeInAmulet
                fadeOutAnimation = fadeOutAmulet
                validDrop = itemIsAnAmulet(self.currentItemView.tag)
                finalView = self.amuletSlot
            }
           
            
           UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.currentItemView.alpha = 0.0
                    self.currentItemView.transform = CGAffineTransformIdentity
            
                    if validDrop {
                            fadeOutAnimation()
                    }

                }, completion: { (result) -> Void in
                    
                    if validDrop {
                        finalView.image = self.currentItemView.image
                        finalView.tag = self.currentItemView.tag
                        fadeInAnimation()
                        self.createCharacter()
                    }

                    self.currentItemView.image = nil
            })
 
        }
 

    }
    
    // MARK: - Drag and Drop Auxiliary Methods
    
    
    private func itemForPosition(position:CGPoint) -> UIImageView! {
        
        for itemView in self.itemViews {
            
            if (CGRectContainsPoint(itemView.frame, position)) {
                return itemView
            }
            
        }
        
        return nil
    }
    
    private func createDragIconView(selectedItemView:UIImageView) {
        
        //Setup view (yet invisible)
        currentItemView.alpha = 0
        currentItemView.transform = CGAffineTransformIdentity
        currentItemView.frame = CGRect(x: selectedItemView.frame.origin.x+10,y: selectedItemView.frame.origin.y+10,width: selectedItemView.frame.width, height: selectedItemView.frame.height)
        
        //Setup information carried on (item)
        currentItemView.image = selectedItemView.image
        currentItemView.tag = selectedItemView.tag
        
        //Item animation
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.currentItemView.alpha = 1.0
            self.currentItemView.transform = CGAffineTransformScale(self.currentItemView.transform, self.ITEM_SCALE_UP, self.ITEM_SCALE_UP)
            }, completion: { (result) -> Void in
                
        })
    }
    
    
    
    // MARK: - Battle Protocol Methods
    func makeDamage(healthPoints:Int, completion:()->Void) {
        
        hitPointsLabel.textColor = UIColor.redColor()
        hitPointsLabel.alpha = 0
        hitPointsLabel.transform = CGAffineTransformMakeScale(HP_SCALE_DOWN_MIN, HP_SCALE_DOWN_MIN)
        hitPointsLabel.text = String(stringInterpolationSegment: healthPoints)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.hitPointsLabel.alpha = 1
            self.hitPointsLabel.transform = CGAffineTransformMakeScale(self.HP_SCALE_UP, self.HP_SCALE_UP)
        }) { (result) -> Void in
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.hitPointsLabel.transform = CGAffineTransformMakeScale(self.HP_SCALE_DOWN, self.HP_SCALE_DOWN)
                self.hitPointsLabel.alpha = 0.0
            }, completion: { (result) -> Void in
                completion()
            })
        }
        
    }
    
    func healDamage(healthPoints:Int, completion:()->Void) {
        
        hitPointsLabel.textColor = UIColor.greenColor()
        hitPointsLabel.alpha = 0
        hitPointsLabel.transform = CGAffineTransformMakeScale(HP_SCALE_DOWN_MIN, HP_SCALE_DOWN_MIN)
        hitPointsLabel.text = String(stringInterpolationSegment: healthPoints)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.hitPointsLabel.alpha = 1
            self.hitPointsLabel.transform = CGAffineTransformMakeScale(self.HP_SCALE_UP, self.HP_SCALE_UP)
            }) { (result) -> Void in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.hitPointsLabel.transform = CGAffineTransformMakeScale(self.HP_SCALE_DOWN, self.HP_SCALE_DOWN)
                    self.hitPointsLabel.alpha = 0.0
                    }, completion: { (result) -> Void in
                        completion()
                })
        }
    }
    
    func pass(completion:()->Void) {
        //Do nothing
        completion()
    }
    
    func getCharacter() -> Character! {
        return character
    }
    
    
    // MARK: - Auxiliary methods
    
    func itemIsAWeapon(id:Int) -> Bool {
        return (id >= 0 && id <= 2)
    }
    
    func itemIsAnAmulet(id:Int) -> Bool {
        return (id >= 3 && id <= 4)
    }
    
    // MARK: - Animation Related Methods
    
    func fadeInAmulet() {
        self.amuletSlot.alpha = 1
    }
    
    func fadeOutAmulet() {
        self.amuletSlot.alpha = 0
    }

    func fadeInWeapon() {
        self.weaponSlot.alpha = 1
    }
    
    func fadeOutWeapon() {
        self.weaponSlot.alpha = 0
    }
   


}
