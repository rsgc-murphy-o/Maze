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
        
    let background = SKSpriteNode(imageNamed: "Icy Background")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = self.frame.size
        
        background.zPosition = -1
        addChild(background)
        
        let actionWait = SKAction.wait(forDuration: 2)
        let actionSpawn = SKAction.run () {[weak self] in self?.spawnObstacles()}
        let actionSequence = SKAction.sequence ([actionWait, actionSpawn])
        let actionObstacleRepeat = SKAction.repeatForever(actionSequence)
        run(actionObstacleRepeat)
        
    }
    
    override func update(_ currentTime: TimeInterval){
        // check for collisions
        checkCollisions()
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
    
    func spawnObstacles(){
    
        let obstacle = SKSpriteNode(imageNamed: "Block")
        
        obstacle.setScale(6)
        
        let horizontalPosition = CGFloat(arc4random_uniform(UInt32(size.width)))
        let verticalPosition = size.height + obstacle.size.height
        
        let startingPosition = CGPoint(x: horizontalPosition, y: verticalPosition)
        
        obstacle.position = startingPosition
        obstacle.zPosition = 2
        
        obstacle.name = "obstacle"
        
        addChild(obstacle)
        
        
        
        let endingPosition = CGPoint(x: horizontalPosition, y: 0 - obstacle.size.height)
        
        let actionMove = SKAction.move(to: endingPosition, duration: 5)
        
        let actionRemove = SKAction.removeFromParent()
        
        let actionSequene = SKAction.sequence([actionMove, actionRemove])
        
        obstacle.run(actionSequene)
        
    
    }
    
    func checkCollisions() {
    
        var hitObstacles : [SKSpriteNode] = []
        
        enumerateChildNodes(withName: "obstacle", using: {
        
            node, _ in
            
            let obstacle = node as! SKSpriteNode
            
            if obstacle.frame.insetBy(dx: 20, dy: 20).intersects(self.Ball.frame.insetBy(dx: 40, dy: 40)) {
                
                hitObstacles.append(obstacle)
            }
        
        })
        
        for obstacle in hitObstacles {
            ballHit(by: obstacle)
        }
        
    }
    
    func ballHit (by obstacle: SKSpriteNode) {
        obstacle.removeFromParent()
    }
    
}




