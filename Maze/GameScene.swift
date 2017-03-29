//
//  GameScene.swift
//  Maze
//
//  Created by Oliver Murphy on 2017-03-02.
//  Copyright © 2017 Oliver Murphy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let Feild_hockey_ball = SKSpriteNode(imageNamed: "Feild_hockey_ball")
    
    override func didMove( to view: SKView) {
        backgroundColor = SKColor.black
        
        let background = SKSpriteNode(imageNamed: "icybackground")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = self.frame.size
        background.zPosition = -1
        addChild(background)
        
        Feild_hockey_ball.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(Feild_hockey_ball)
        
    }
}


 
