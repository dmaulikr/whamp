//
//  GameOverArcade.swift
//  whamp
//
//  Created by Buka Cakrawala on 7/28/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import SpriteKit

class GameOverArcade: SKScene {
    var arcadeLabel: SKLabelNode!
    //COLORED SQUARES
    var blueSquare: SKSpriteNode!
    var greenSquare: SKSpriteNode!
    var yellowSquare: SKSpriteNode!
    //PLAY LOGO
    var playLogo: SKSpriteNode!
    //MENU LOGO
    var menuLogo: SKSpriteNode!
    //LIVE SCORE LABEL
    var liveScoreLabel: SKLabelNode!
    //LIVE HIGHSCORES
    var liveHighScore: SKLabelNode!
    //TRANSITION
    var transition: SKTransition!
    
    
    
    
    /***********************************************************************/
    func rgbaColor(red: Int, green: Int, blue: Int, alpha: Float) -> SKColor {
        return SKColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    /************************************************************************/
    
    
    
    override func didMoveToView(view: SKView) {
        //COLORS
        let blueColor = rgbaColor(36, green: 100, blue: 238, alpha: 1.0)
        let greenColor = rgbaColor(21, green: 166, blue: 48, alpha: 1.0)
        let yellowColor = rgbaColor(226, green: 219, blue: 8, alpha: 1.0)
        //     *****************************************************************//
        //THE SQUARES
        blueSquare = SKSpriteNode(color: blueColor, size: CGSize(width: frame.width, height: frame.height - (frame.height / 4)))
        blueSquare.position = CGPoint(x: 0, y: 0 + (frame.height / 4))
        blueSquare.anchorPoint = CGPoint(x: 0, y: 0)
        blueSquare.zPosition = -2
        addChild(blueSquare)
    
        greenSquare = SKSpriteNode(color: greenColor, size: CGSize(width: frame.width / 2, height: frame.height / 4))
        greenSquare.position = CGPoint(x: 0, y: 0)
        greenSquare.anchorPoint = CGPoint(x: 0, y: 0)
        greenSquare.zPosition = -2
        greenSquare.name = "greenSquare"
        addChild(greenSquare)
        
        yellowSquare = SKSpriteNode(color: yellowColor
            , size: CGSize(width: frame.width
                 / 2, height: frame.height / 4))
        yellowSquare.position = CGPoint(x: 0 + (frame.width / 2), y: 0)
        yellowSquare.anchorPoint = CGPoint(x: 0, y: 0)
        yellowSquare.zPosition = -2
        yellowSquare.name = "yellowSquare"
        addChild(yellowSquare)
        // ******************************************************************/
        //THE LABELS
        arcadeLabel = SKLabelNode(text: "ARCADE")
        arcadeLabel.color = UIColor.clearColor()
        arcadeLabel.position = CGPoint(x: frame.width / 2, y: frame.height - 30)
        arcadeLabel.fontName = "Geneva"
        arcadeLabel.fontSize = 20.0
        addChild(arcadeLabel)
        //THE LOGOS
        menuLogo = SKSpriteNode(imageNamed: "menuLogo")
        menuLogo.position = CGPoint(x: frame.width / 4, y: (0 + (frame.height / 4)) / 2)
        menuLogo.name = "menuLogo"
        addChild(menuLogo)
        
        playLogo = SKSpriteNode(imageNamed: "playLogo")
        playLogo.position = CGPoint(x: frame.width - (frame.width / 4), y: (0 + (frame.height / 4)) / 2)
        playLogo.name = "playLogo"
        addChild(playLogo)
        //*********************************************************************/
        liveScoreLabel = SKLabelNode(text: "\(arcadeLiveScore)")
        liveScoreLabel.fontSize = 120
        liveScoreLabel.fontColor = UIColor.blackColor()
        liveScoreLabel.fontName = "Geneva"
        liveScoreLabel.position = CGPoint(x: frame.width / 2, y: frame.height - (frame.height / 3))
        addChild(liveScoreLabel)
        
        liveHighScore = SKLabelNode(text: "BEST: \(arcadeLiveHighScore)")
        liveHighScore.fontSize = 30
        liveHighScore.color = UIColor.clearColor()
        liveHighScore.fontName = "Geneva"
        liveHighScore.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addChild(liveHighScore)
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        if let location = touches.first?.locationInNode(self) {
            let touchNode = nodeAtPoint(location)
            
            if touchNode.name == "greenSquare" || touchNode.name == "menuLogo" {
                transition = SKTransition.revealWithDirection(.Down, duration: 1)
                let nextScene = MainMenu(size: (scene?.size)!)
                nextScene.scaleMode = .ResizeFill
                
                scene?.view?.presentScene(nextScene, transition: transition)
            }; if touchNode.name == "yellowSquare" || touchNode.name == "playLogo"{
                transition = SKTransition.revealWithDirection(.Left, duration: 1)
                let nextScene = ArcadeMode(size: (scene?.size)!)
                nextScene.scaleMode = .ResizeFill
                
                scene?.view?.presentScene(nextScene, transition: transition)
            }
        }
    }
    
}