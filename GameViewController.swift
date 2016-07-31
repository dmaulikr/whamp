//
//  GameViewController.swift
//  whamp
//
//  Created by Buka Cakrawala on 7/11/16.
//  Copyright (c) 2016 Buka Cakrawala. All rights reserved.
//


import SpriteKit
//Live Scores are the score that will be shown when the player/user enter the GameOver scene.
var arcadeLiveScore: Int = 0
var infernoLiveScore: Int = 0
/****************************************/
var arcadeLiveHighScore: Int = 0
var infernoLiveHighScore: Int = 0


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = MainMenu(fileNamed:"MainMenu") {
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true

            skView.ignoresSiblingOrder = true
        
            scene.scaleMode = .ResizeFill
            
            skView.presentScene(scene)
        }
 
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

}
