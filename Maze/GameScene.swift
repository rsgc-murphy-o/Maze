//
//  GameScene.swift
//  Maze
//
//  Created by Oliver Murphy on 2017-03-02.
//  Copyright © 2017 Oliver Murphy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let Ball = SKSpriteNode(imageNamed: "ball")
    
    let Block = SKSpriteNode(imageNamed: "Block")
    
    override func didMove( to view: SKView) {
        backgroundColor = SKColor.black
        
        Ball.position = CGPoint(x: size.width/2, y: size.height/2)
        Ball.zPosition = 1 
        addChild(Ball)
        
        Block.position = CGPoint(x: size.width/2, y: size.height/2)
        Block.zPosition = 1
        addChild(Block)
        
    let background = SKSpriteNode(imageNamed: "Icy Background")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = self.frame.size
        
        background.zPosition = -1
        addChild(background)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        //print(touchLocation.x)
        //print(touchLocation.y)
        
        moveBall(touchLocation: touchLocation)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        //print(touchLocation.x)
        //print(touchLocation.y)
        
        moveBall(touchLocation: touchLocation)
        
    }

    
    func moveBall(touchLocation: CGPoint) {
        
        let destination = CGPoint(x: touchLocation.x, y: Ball.position.y )
        
        let actionMove = SKAction.move(to: destination, duration: 1)
        
        Ball.run(actionMove)
        
    }
}
