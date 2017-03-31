//
//  GameScene.swift
//  Maze
//
//  Created by Oliver Murphy on 2017-03-02.
//  Copyright © 2017 Oliver Murphy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let ball = SKSpriteNode(imageNamed: "ball")
    
    override func didMove( to view: SKView) {
        backgroundColor = SKColor.black
        
        ball.position = CGPoint(x: size.width/2, y: size.height/2)
        ball.zPosition = 1 
        addChild(ball)
        
        let background = SKSpriteNode(imageNamed: "Icy Background")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = self.frame.size
        
        background.zPosition = -1
        addChild(background)
        
    }
}


 
