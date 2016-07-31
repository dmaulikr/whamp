//
//  GameOverInferno.swift
//  whamp
//
//  Created by Buka Cakrawala on 7/29/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import SpriteKit


class GameOverInferno: SKScene {
    var infernoLabel: SKLabelNode!
    /*****************************/
    var orangeSquare: SKSpriteNode!
    var redSquare: SKSpriteNode!
    var purpleSquare: SKSpriteNode!
    //PLAY LOGO
    var playLogo: SKSpriteNode!
    //MENU LOGO
    var menuLogo: SKSpriteNode!
    //LIVE SCORE LABEL
    var infernoLiveScoreLabel: SKLabelNode!
    var infernoOverHighScore: SKLabelNode!
    //transition
    var transition: SKTransition!
    
    /***********************************************************************/
    func rgbaColor(red: Int, green: Int, blue: Int, alpha: Float) -> SKColor {
        return SKColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    /************************************************************************/
    
    
    override func didMoveToView(view: SKView) {
        //COLORS
        let orangeColor = rgbaColor(214, green: 99, blue: 0, alpha: 0.7)
        let redColor = rgbaColor(243, green: 29, blue: 1, alpha: 0.7)
        let purpleColor = rgbaColor(99, green: 7, blue: 88, alpha: 0.7)
        /****************************************************************/
        //THE SQUARES
        orangeSquare = SKSpriteNode(color: orangeColor, size: CGSize(width: frame.width, height: frame.height - (frame.height / 4)))
        orangeSquare.position = CGPoint(x: 0, y: 0 + (frame.height / 4))
        orangeSquare.anchorPoint = CGPoint(x: 0, y: 0)
        orangeSquare.zPosition = -2
        addChild(orangeSquare)
        
        redSquare = SKSpriteNode(color: redColor, size: CGSize(width: frame.width / 2, height: frame.height / 4))
        redSquare.position = CGPoint(x: 0, y: 0)
        redSquare.anchorPoint = CGPoint(x: 0, y: 0)
        redSquare.zPosition = -2
        redSquare.name = "redSquare"
        addChild(redSquare)
        
        purpleSquare = SKSpriteNode(color: purpleColor
            , size: CGSize(width: frame.width
                / 2, height: frame.height / 4))
        purpleSquare.position = CGPoint(x: 0 + (frame.width / 2), y: 0)
        purpleSquare.anchorPoint = CGPoint(x: 0, y: 0)
        purpleSquare.zPosition = -2
        purpleSquare.name = "purpleSquare"
        addChild(purpleSquare)
        // ******************************************************************/
        //THE LABELS
        infernoLabel = SKLabelNode(text: "INFERNO")
        infernoLabel.color = UIColor.clearColor()
        infernoLabel.position = CGPoint(x: frame.width / 2, y: frame.height - 30)
        infernoLabel.fontName = "Geneva"
        infernoLabel.fontSize = 20.0
        addChild(infernoLabel)
        //THE LOGOS
        menuLogo = SKSpriteNode(imageNamed: "WhiteMenu")
        menuLogo.position = CGPoint(x: frame.width / 4, y: (0 + (frame.height / 4)) / 2)
        menuLogo.name = "menuLogo"
        addChild(menuLogo)
        
        playLogo = SKSpriteNode(imageNamed: "WhitePlay")
        playLogo.position = CGPoint(x: frame.width - (frame.width / 4), y: (0 + (frame.height / 4)) / 2)
        playLogo.name = "playLogo"
        addChild(playLogo)
        //*********************************************************************/
        infernoLiveScoreLabel = SKLabelNode(text: "\(infernoLiveScore)")
        infernoLiveScoreLabel.fontSize = 120
        infernoLiveScoreLabel.fontColor = UIColor.blackColor()
        infernoLiveScoreLabel.fontName = "Geneva"
        infernoLiveScoreLabel.position = CGPoint(x: frame.width / 2, y: frame.height - (frame.height / 4))
        addChild(infernoLiveScoreLabel)
        
        
        infernoOverHighScore = SKLabelNode(text: "BEST: \(infernoLiveHighScore)")
        infernoOverHighScore.fontSize = 30
        infernoOverHighScore.color = UIColor.clearColor()
        infernoOverHighScore.fontName = "Geneva"
        infernoOverHighScore.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addChild(infernoOverHighScore)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        if let location = touches.first?.locationInNode(self) {
            let touchNode = nodeAtPoint(location)
            
            if touchNode.name == "redSquare" || touchNode.name == "menuLogo" {
                transition = SKTransition.revealWithDirection(.Down, duration: 1)
                let nextScene = MainMenu(size: (scene?.size)!)
                nextScene.scaleMode = .ResizeFill
                
                scene?.view?.presentScene(nextScene, transition: transition)
            }; if touchNode.name == "purpleSquare" || touchNode.name == "playLogo"{
                transition = SKTransition.revealWithDirection(.Left, duration: 1)
                let nextScene = InfernoMode(size: (scene?.size)!)
                nextScene.scaleMode = .ResizeFill
                
                scene?.view?.presentScene(nextScene, transition: transition)
            }
        }
    }
    
    
}