//
//  GameScene.swift
//  Maze
//
//  Created by Oliver Murphy on 2017-03-02.
//  Copyright © 2017 Oliver Murphy. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    let ball = SKSpriteNode(imageNamed: "ball")
    
    override func didMove( to view: SKView) {
        backgroundColor = SKColor.black
        
        let background = SKSpriteNode(imageNamed: "icybackground")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = self.frame.size
        background.zPosition = -1
        addChild(background)
        
        ball.position = CGPoint(x: size.width/2, y: 250)
        addChild(ball)
        
    }
}


 
