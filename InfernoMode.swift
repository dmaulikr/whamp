//
//  InfernoMode.swift
//  whamp
//
//  Created by Buka Cakrawala on 7/13/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import Foundation
import SpriteKit

enum InfernoState {
    case Active, GameOver
}

enum InfernoBlock: String {
    case greenBlock = "greenInferno"
    case yellowBlock = "yellowBlock"
    case pinkBlock = "pinkBlock"
    case blackBlock = "blackBlock"
    
    
    static let InfernoColors = [InfernoBlock.greenBlock, InfernoBlock.yellowBlock, InfernoBlock.pinkBlock, InfernoBlock.blackBlock]
    static func randomInfernoColors() -> InfernoBlock {
        return InfernoColors[Int(arc4random()) % InfernoColors.count]
    }
}

class InfernoMode: SKScene {
    var defaultScene: InfernoState = .Active
    
    //Colored Buttons variable
    var greenButton: SKSpriteNode!
    var yellowButton: SKSpriteNode!
    var pinkButton: SKSpriteNode!
    var blackButton: SKSpriteNode!
    var timer: NSTimer?
    let moveUpTime: CGFloat = 15.0 // How long in second for a block to go from the bottom to the top
    let timeBetweenBlocks: NSTimeInterval = 0.5
    let blockHeight:CGFloat = 20.0
    var blocksArray = [SKSpriteNode]()
    //TRANSITION
    var transition: SKTransition!
    

    //Putting scores
    var initialLabel: SKLabelNode!
    var infernoScoreLabel: SKLabelNode!
    var infernoPoints: Int = 0 {
        didSet{
            infernoScoreLabel.text = "\(infernoPoints)"
        }
    }
    //Instance variable for highscores
    var infernoHighScoreLabel: SKLabelNode!
    var infernoHighScorePoints: Int?
    
    
    /****************MAKE INFERNO SCORE LABEL FUNCTION**/
    func makeInfernoScoreLabel(x: CGFloat, y: CGFloat, color: UIColor) -> SKLabelNode {
        initialLabel = SKLabelNode(text: "\(infernoPoints)")
        initialLabel.color = color
        initialLabel.fontSize = 20
        initialLabel.position = CGPoint(x: x, y: y)
        initialLabel.fontName = "Geneva"
        initialLabel.zPosition = 10
        addChild(initialLabel)
        return initialLabel
    }
    /*****************************************************************/
    override func didMoveToView(view: SKView) {
        let fireFlies = SKEmitterNode(fileNamed: "FireFlies")
        fireFlies?.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addChild(fireFlies!)
        ///////////////////////////////////////////////
        let secondsPerPixel = moveUpTime / (frame.height + blockHeight)
        let secondsPerBlock = blockHeight * secondsPerPixel
        let timeInterval = secondsPerBlock * 1.05
        
        
        var highScoreDefault = NSUserDefaults.standardUserDefaults()
        
        if (highScoreDefault.valueForKey("infernoHighscore") != nil){ infernoHighScorePoints = highScoreDefault.valueForKey("infernoHighscore") as! NSInteger!
        }
        
        infernoScoreLabel = makeInfernoScoreLabel(frame.width / 2, y: frame.height - 20, color: UIColor.clearColor())
        /*****************************************************************/
        //RGBA color converter; convert each RGBA value into over 255.0
        func rgbColor(red: Int, green: Int, blue: Int, alpha: Float) -> SKColor {
            return SKColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
            }
        
        
        /********************************************************/
        //Blocks are created here
        //Set time between blocks
        let waitForInfernoBlock = SKAction.waitForDuration(timeBetweenBlocks)
        let newInfernoBlock = SKAction.runBlock {
            self.makeInfernoBlocks()
        }
        
        let infernoBlockSequence = SKAction.sequence([waitForInfernoBlock, newInfernoBlock])
        runAction(SKAction.repeatActionForever(infernoBlockSequence))
        
        /****************************************************/
        
        
        //CALLING THE rgbColor function
        //This is where all color of the buttons are being made
        //GREEN
        let greenColorButton = rgbColor(31, green: 166, blue: 27, alpha: 1.0)
        //YELLOW
        let yellowColorButton = rgbColor(234, green: 250, blue: 66, alpha: 1.0)
        //PINK
        let pinkColorButton = rgbColor(240, green: 14, blue: 108, alpha: 1.0)
        //BLACK
        let blackColorButton = rgbColor(0, green: 0, blue: 0, alpha: 1.0)
        
        
        greenButton = SKSpriteNode(color: greenColorButton, size: CGSize(width: frame.width / 4, height: frame.height / 8))
        greenButton.position = CGPoint(x: 0, y: 0)
        greenButton.anchorPoint = CGPoint(x: 0, y: 0)
        greenButton.zPosition = 10
        greenButton.name = "greenButton"
        addChild(greenButton)
        
        yellowButton = SKSpriteNode(color: yellowColorButton, size: CGSize(width: frame.width / 4, height: frame.height / 8))
        yellowButton.position = CGPoint(x: frame.width / 4, y: 0)
        yellowButton.anchorPoint = CGPoint(x: 0, y: 0)
        yellowButton.zPosition = 10
        yellowButton.name = "yellowButton"
        addChild(yellowButton)
        
        pinkButton = SKSpriteNode(color: pinkColorButton, size: CGSize(width: frame.width / 4, height: frame.height / 8))
        pinkButton.position = CGPoint(x: (frame.width / 4) * 2, y: 0)
        pinkButton.anchorPoint = CGPoint(x: 0, y: 0)
        pinkButton.zPosition = 10
        pinkButton.name = "pinkButton"
        addChild(pinkButton)

        blackButton = SKSpriteNode(color: blackColorButton, size: CGSize(width: frame.height / 4, height: frame.height / 8))
        blackButton.position = CGPoint(x: (frame.width / 4) * 3, y: 0)
        blackButton.anchorPoint = CGPoint(x: 0, y: 0)
        blackButton.zPosition = 10
        blackButton.name = "blackButton"
        addChild(blackButton)
    }
    
    func makeInfernoBlocks() {
        // Create a block
        let blockName = InfernoBlock.randomInfernoColors().rawValue
        let infernoBlockTexture = SKTexture(imageNamed: blockName)
        let infernoBlockNode = SKSpriteNode(texture: infernoBlockTexture)
        addChild(infernoBlockNode)
        
        
        infernoBlockNode.name = blockName
        
        print("--------------------------")
        print(infernoBlockNode.name, blockName)
        print("--------------------------")
        
        // Append block to array...
        blocksArray.append(infernoBlockNode)
        
        infernoBlockNode.position.x = frame.width / 2
        infernoBlockNode.position.y = -20
        let infernoMove = SKAction.moveTo(CGPoint(x: frame.width / 2, y: frame.height + blockHeight), duration: Double(moveUpTime))
        //Inferno Horizontal Move
        let infernoToTheLeft = SKAction.moveToX(0, duration: 1)
        let infernoToTheRight = SKAction.moveToX(frame.width, duration: 1)
        let infernoHorizontalMove = SKAction.sequence([infernoToTheLeft, infernoToTheRight])
        //let infernoLateral = SKAction.repeatActionForever(infernoHorizontalMove)
        let infernoLateral = SKAction.repeatAction(infernoHorizontalMove, count: 8)
        
        
        let infernoBlockMoves = SKAction.group([infernoMove, infernoLateral])
        let youLose = SKAction.runBlock { 
            print("YOU LOSE")
            self.gameOver()
        }
        //sequence from making the inferno blocks moving and then remove it
        let infernoSequence = SKAction.sequence([infernoBlockMoves, youLose])
        //Run the action of the sequence
        infernoBlockNode.runAction(infernoSequence)
    }

    
    /****************************/
    //Touches began function when colored buttons are tapped
    override func touchesBegan(touches: Set<UITouch>, withEvent event:
        UIEvent?) {
        if defaultScene == .GameOver {return}
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if greenButton.containsPoint(location) {
                print("greenButton Inferno Mode is activated!")
                removeBlocksOfColor(InfernoBlock.greenBlock)
            } else if yellowButton.containsPoint(location) {
                print("yellowButton Inferno Mode is activated!")
                removeBlocksOfColor(InfernoBlock.yellowBlock)
                
            } else if pinkButton.containsPoint(location) {
                print("pinkButton Inferno Mode is activated!")
                removeBlocksOfColor(InfernoBlock.pinkBlock)
            } else if blackButton.containsPoint(location) {
                print("blackButton Inferno Mode is activated!")
                removeBlocksOfColor(InfernoBlock.blackBlock)

            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        /* Called before each frame is rendered */
        
        // saveHighscore()
    }
    /******************************/
    
    
    
    func saveHighscore() {
        print("Saving High score!!!")
        if (infernoPoints > infernoHighScorePoints) {
            print("New High score: \(infernoPoints) old high score: \(infernoHighScorePoints)")
            
            infernoHighScorePoints = infernoPoints
            let highscoreDefault = NSUserDefaults.standardUserDefaults()
            highscoreDefault.setValue(infernoHighScorePoints, forKey: "infernoHighscore")
            highscoreDefault.synchronize()
            
            let n = highscoreDefault.valueForKey("infernoHighscore") as! Int
            print("High score saved as: \(n)")
        }
        infernoLiveHighScore = infernoHighScorePoints!
        
        
        //        if (arcadePoints > highScorePoints) {
        //            highScorePoints = arcadePoints
        //
        //            let highscoreDefault = NSUserDefaults.standardUserDefaults()
        //            highscoreDefault.setValue(highScorePoints, forKey: "highscore")
        //            highscoreDefault.synchronize()
        //
        //        }
        //        arcadeLiveHighScore = highScorePoints!

    }
    
    
    
    
    /******************************/
    
    func removeBlocksOfColor(color: InfernoBlock) {
        // get first block in array
        let firstBlock = blocksArray[0]
        // compare the block color to color
        
        print("******************")
        print(color.rawValue, firstBlock.name!)
        
        if color.rawValue == firstBlock.name! {
            firstBlock.removeFromParent()
            blocksArray.removeAtIndex(0)
            infernoPoints += 1
            infernoLiveScore = infernoPoints
        } else {
            print("YOU LOSE!")
            gameOver()
        }
        
    }
    
    func gameOver() {
        saveHighscore()
        defaultScene = .GameOver
        self.removeAllActions()
        for block in blocksArray {
            block.removeAllActions()
        }
        transition = SKTransition.revealWithDirection(.Left, duration: 1)
        let nextScene = GameOverInferno(size: (scene?.size)!)
        nextScene.scaleMode = .ResizeFill
        scene?.view?.presentScene(nextScene, transition: transition)
    }
    
    
    
}



