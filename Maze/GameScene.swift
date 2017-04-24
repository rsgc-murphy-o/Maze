//
//  GameScene.swift
//  Maze
//
//  Created by Oliver Murphy on 2017-03-02.
//  Copyright © 2017 Oliver Murphy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let Ball = SKSpriteNode(imageNamed: "ball")                                // Add the ball sprite.
    
    let Block = SKSpriteNode(imageNamed: "Block")                              // Add the block sprite.
    
    override func didMove( to view: SKView) {
        backgroundColor = SKColor.black
        Ball.position = CGPoint(x: size.width/2, y: size.height/2)             // Configure how the ball sprite looks.
        Ball.zPosition = 1                                                     // Ensures that the ball is drawn above the background.
        addChild(Ball)                                                         // Add the ball sprite to the scene.
        
    let background = SKSpriteNode(imageNamed: "Icy Background")                // Adding a sprite to represent background.
        background.position = CGPoint(x: size.width/2, y: size.height/2)       // Anchor the background image in the middle of the screen.
        background.size = self.frame.size                                      // Set the size of the background sprite to the screen size.
        background.zPosition = -1                                              // Ensures that the background is drawn under the ball sprite.
        addChild(background)                                                   // Add the background sprite to the scene.
        
        let actionWait = SKAction.wait(forDuration: 2)
        let actionSpawn = SKAction.run () {[weak self] in self?.spawnObstacles()}
        let actionSequence = SKAction.sequence ([actionWait, actionSpawn])
        let actionObstacleRepeat = SKAction.repeatForever(actionSequence)
        run(actionObstacleRepeat)
        
    }
    
    override func update(_ currentTime: TimeInterval){
        checkCollisions()                                                      // check for collisions
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {// Method responds to single touch.
        guard let touch = touches.first else {                                 // When you touch the device.
            return
        }
        
        let touchLocation = touch.location(in: self)                           // Get the location of the first touch.
        print(touchLocation.x)                                                 // Print the x location in the console.
        print(touchLocation.y)                                                 // Print the y location in the console.
        moveBall(touchLocation: touchLocation)                                 // Use the moveBall method again.
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {//
        guard let touch = touches.first else {                                 //
            return
        }
        
        let touchLocation = touch.location(in: self)
        print(touchLocation.x)                                                 // Print the x location in the console.
        print(touchLocation.y)                                                 // Print the y location in the console.
        moveBall(touchLocation: touchLocation)                                 // Use the moveBall method again.
        
    }

    
    func moveBall(touchLocation: CGPoint) {                                    // Moves ball sprite to touch location.
        let destination = CGPoint(x: touchLocation.x, y: Ball.position.y )     // Move santa horizontally.
        let actionMove = SKAction.move(to: destination, duration: 1)           // Create an action.
        Ball.run(actionMove)                                                   // Tell the ball sprite to move.
        
    }
    
    func spawnObstacles(){                                                     // Method to spawn multiple obstacles for the ball to dodge.
    
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




