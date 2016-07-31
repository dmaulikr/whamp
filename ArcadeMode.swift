//
//  ArcadeMode.swift
//  whamp
//
//  Created by Buka Cakrawala on 7/11/16.
//  Copyright (c) 2016 Buka Cakrawala. All rights reserved.
//

import SpriteKit
/***********************************************************/
enum GameSceneState {
    case Active, Gameover
}

enum BlockColor: String {
    case RedBlock = "RedBlock"
    case PurpleBlock = "PurpleBlock"
    case BlueBlock = "BlueBlock"
    
    static let colors = [BlockColor.RedBlock, BlockColor.PurpleBlock, BlockColor.BlueBlock]
    //randomColor function to generate random blocks
    static func randomColor() -> BlockColor {
        return colors[Int(arc4random()) % colors.count]
    }
}
/***********************************************************/
class ArcadeMode: SKScene {
    //DEFAULT GAMESTATE OF THE GAME/////////////////////////////
    var gameState: GameSceneState = .Active
    /*************************************/
    var transition: SKTransition!
    
    //COLORED BUTTONS
    var redButton: SKSpriteNode!
    var blueButton: SKSpriteNode!
    var purpleButton: SKSpriteNode!
    /*********************************/
    //Timer:
    var arcadeTimer: NSTimer!
    let moveDownTime: CGFloat = 5.0
    let timeBetweenBlocks: NSTimeInterval = 0.37
    let arcadeBlocksHeight: CGFloat = 20.0
    //Array
    var arcadeBlocksArray = [SKSpriteNode]()
    //Label and putting score label
    var arcadeInitialLabel: SKLabelNode!
    var arcadeScoreLabel: SKLabelNode!
    var arcadePoints: Int = 0 {
        didSet {
            arcadeScoreLabel.text = "\(arcadePoints)"
        }
    }
    var highScoreLabel: SKLabelNode!
    var highScorePoints: Int?
    
    func makeArcadeScoreLabel(x: CGFloat, y: CGFloat, color: UIColor) ->SKLabelNode {
        arcadeInitialLabel = SKLabelNode(text: "\(arcadePoints)")
        arcadeInitialLabel.fontName = "Geneva"
        arcadeInitialLabel.color = color
        arcadeInitialLabel.fontSize = 20
        arcadeInitialLabel.position = CGPoint(x: x, y: y)
        arcadeInitialLabel.zPosition = 20
        addChild(arcadeInitialLabel)
        return arcadeInitialLabel
        
    }
    
    override func didMoveToView(view: SKView) {
        let magicParticle = SKEmitterNode(fileNamed: "Magic")!
        magicParticle.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addChild(magicParticle)
        
        var highScoreDefault = NSUserDefaults.standardUserDefaults()
        if (highScoreDefault.valueForKey("highscore") != nil){
            highScorePoints = highScoreDefault.valueForKey("highscore") as! NSInteger!
            
        }

        
/*************************************************************************/
        let secondsPerPixel = moveDownTime / (frame.height + arcadeBlocksHeight)
        let secondsPerBlock = arcadeBlocksHeight * secondsPerPixel
        let timeInterval = secondsPerBlock * 1.05
        
        // make wait action
        let wait = SKAction.waitForDuration(timeBetweenBlocks)
        
        let newBlock = SKAction.runBlock {
            self.makeBlock()
        }
        // make sequence of wait and newBlock
        let anotherSequence = SKAction.sequence([wait, newBlock])
        // repeat forever action of sequence
        runAction(SKAction.repeatActionForever(anotherSequence))
        // run action repeat action
        
/****************************************************************************************/
        // rgbColor function helps to convert each rgb value over 255.0
        func rgbColor(red: Int, green: Int, blue: Int, alpha: Float) -> SKColor {
            return SKColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
        }

        
        let redButtonColor = rgbColor(172, green: 54, blue: 72, alpha: 0.9)
        let blueButtonColor = rgbColor(100, green: 181, blue: 239, alpha: 0.8)
        let purpleButtonColor = rgbColor(93, green: 13, blue: 108, alpha: 1.0)

        //RED button in Arcade Mode
        redButton = SKSpriteNode(color: redButtonColor, size: CGSize(width: frame.width / 3, height: frame.height / 6))
        redButton.anchorPoint = CGPoint(x: 0, y: 0)
        redButton.position = CGPoint(x: 0, y: 0)
        addChild(redButton)
        redButton.name = "redButton"
        redButton.zPosition = 10
        
        //PURPLE button in Arcade Mode
        purpleButton = SKSpriteNode(color: purpleButtonColor
            , size: CGSize(width: frame.width / 3, height: frame.height / 6))
        purpleButton.anchorPoint = CGPoint(x: 0, y: 0)
        purpleButton.position = CGPoint(x: frame.width / 3, y: 0)
        addChild(purpleButton)
        purpleButton.name = "purpleButton"
        purpleButton.zPosition = 10
        
        //BLUE button in Aracade Mode
        blueButton = SKSpriteNode(color: blueButtonColor, size: CGSize(width: frame.width / 3, height: frame.height / 6))
        blueButton.anchorPoint = CGPoint(x: 0, y: 0)
        blueButton.position = CGPoint(x: (frame.width / 3) * 2, y: 0)
        addChild(blueButton)
        blueButton.name = "blueButton"
        blueButton.zPosition = 10
/****************************************************************************************/
        arcadeScoreLabel = makeArcadeScoreLabel(frame.width / 2, y: frame.height - 20, color: UIColor.clearColor())
        }
    
    //Make Block is Making the Blocks, determining the position a nd SKAction to fall off
    func makeBlock() {
        let arcadeBlockName = BlockColor.randomColor().rawValue
        let blockTexture = SKTexture(imageNamed: arcadeBlockName)
        let block = SKSpriteNode(texture: blockTexture)
        addChild(block)
        
        block.name = arcadeBlockName
        
        arcadeBlocksArray.append(block)
        
        block.position.x = frame.width / 2
        block.position.y = frame.height + 24
        let move = SKAction.moveToY(100, duration: Double(moveDownTime))
        let youLose = SKAction.runBlock { 
            print("YOU LOSE")
            self.gameOver()
        }
        let arcadeSequence = SKAction.sequence([move, youLose])
        block.runAction(arcadeSequence)
    }

    
    //When you tap a certain button, do an action which is print
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        if gameState == .Gameover {return}
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if redButton.containsPoint(location) {
                print("redButton is activated!")
                removesArcadeBlock(BlockColor.RedBlock)
            } else if purpleButton.containsPoint(location) {
                print("purpleButton is activated!")
                removesArcadeBlock(BlockColor.PurpleBlock)
            } else if blueButton.containsPoint(location) {
                print("blueButton is activated!")
                removesArcadeBlock(BlockColor.BlueBlock)
            }
            else {
                gameOver()
            }
        }

        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (arcadePoints > highScorePoints) {
            highScorePoints = arcadePoints
           
            let highscoreDefault = NSUserDefaults.standardUserDefaults()
            highscoreDefault.setValue(highScorePoints, forKey: "highscore")
            highscoreDefault.synchronize()
            
        }
        arcadeLiveHighScore = highScorePoints!
    }
    
    func gameOver() {
        gameState = .Gameover
        self.removeAllActions()
        for block in arcadeBlocksArray {
            block.removeAllActions()
        }
        transition = SKTransition.revealWithDirection(.Left, duration: 1)
        let nextScene = GameOverArcade(size: (scene?.size)!)
        nextScene.scaleMode = .ResizeFill
        scene?.view?.presentScene(nextScene, transition: transition)
        
        
    }
    
    func removesArcadeBlock(color: BlockColor) {
        let firstBlock = arcadeBlocksArray[0]
        
        if color.rawValue == firstBlock.name! {
            firstBlock.removeFromParent()
            arcadeBlocksArray.removeAtIndex(0)
            arcadePoints += 1
            arcadeLiveScore = arcadePoints
        } else {
            print("YOU LOSE!")
            gameOver()
        }

    
    }
}
