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
        backgroundColor = SKColor.black                                        // Background color of the scene is solid black.
        Ball.position = CGPoint(x: size.width/2, y: size.height/2)             // Configure how the ball sprite looks.
        Ball.zPosition = 1                                                     // Ensures that the ball is drawn above the background.
        addChild(Ball)                                                         // Add the ball sprite to the scene.
        
    let background = SKSpriteNode(imageNamed: "Icy Background")                // Adding a sprite to represent background.
        background.position = CGPoint(x: size.width/2, y: size.height/2)       // Anchor the background image in the middle of the screen.
        background.size = self.frame.size                                      // Set the size of the background sprite to the screen size.
        background.zPosition = -1                                              // Ensures that the background is drawn under the ball sprite.
        addChild(background)                                                   // Add the background sprite to the scene.
        
        let actionWait = SKAction.wait(forDuration: 2)                         // Periodically spawn obstacles.
        let actionSpawn = SKAction.run () {[weak self] in self?.spawnObstacles()}// Obstacles spawn.
        let actionSequence = SKAction.sequence ([actionWait, actionSpawn])     // The sequence where the blocks spawn.
        let actionObstacleRepeat = SKAction.repeatForever(actionSequence)      // Configures action sequence to repeat forever.
        run(actionObstacleRepeat)                                              // Now run start the sequence.
        
    }
    
    override func update(_ currentTime: TimeInterval){                         // Runs everytime spritekit updates the game frame.
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)                           // Get the location of the touch.
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
        let obstacle = SKSpriteNode(imageNamed: "Block")                       // Create instance of the obstacle.
        obstacle.setScale(6)                                                   // Set the size of the obstacle.
        let horizontalPosition = CGFloat(arc4random_uniform(UInt32(size.width)))// Define the starting position of the obstacle. (random)
        let verticalPosition = size.height + obstacle.size.height              // Make sure obstacle is starting off screen.
        let startingPosition = CGPoint(x: horizontalPosition, y: verticalPosition)// Define the starting position for the obstacle.
        obstacle.position = startingPosition                                   // Set the starting position.
        obstacle.zPosition = 2                                                 // Ensure the block sprite spawns above the background and ball.
        obstacle.name = "obstacle"                                             // Define the name of the obstacle.
        addChild(obstacle)                                                     // Add the obstacle sprite to the scene.
        
        // Move the obstacle.
        let endingPosition = CGPoint(x: horizontalPosition, y: 0 - obstacle.size.height)
        let actionMove = SKAction.move(to: endingPosition, duration: 5)        // Obstacle moves to end position defined<.
        let actionRemove = SKAction.removeFromParent()                         // This will remove the obstacle from the scene.
        let actionSequene = SKAction.sequence([actionMove, actionRemove])      // Tells what actions to run and in which order.
        obstacle.run(actionSequene)                                            // instead of running a single action, it runs the sequence.
    
    }
    
    func checkCollisions() {                                                   // Function checks for collisions between the ball and the block
        var hitObstacles : [SKSpriteNode] = []                                 // Array that will contain all of the obstacles hitting the ball
        enumerateChildNodes(withName: "obstacle", using: {                     // Find all of the obstacles colliding with the ball.
            node, _ in
            let obstacle = node as! SKSpriteNode                               // Get reference to the node that was found with the name obsta.
            if obstacle.frame.insetBy(dx: 20, dy: 20).intersects(self.Ball.frame.insetBy(dx: 40, dy: 40)) {// check to see if they intersect.
                hitObstacles.append(obstacle)                                  // If the obstacles hits the ball.
            }
        })
        for obstacle in hitObstacles {                                         // loop over all of the obstacles colliding and deal with them.
            ballHit(by: obstacle)                                              // Call function to get rid of the obstacle.
        }
    }
    func ballHit (by obstacle: SKSpriteNode) {                                 // This function removes the block from the game.
        obstacle.removeFromParent()                                            // Removes it from the game scene. 
    }
}
