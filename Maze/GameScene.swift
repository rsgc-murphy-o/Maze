//
//  GameScene.swift
//  Maze
//
//  Created by Oliver Murphy on 2017-03-02.
//  Copyright © 2017 Oliver Murphy. All rights reserved.
//
import Foundation
import SpriteKit

class GameScene: SKScene {
    let Ball = SKSpriteNode(imageNamed: "ball")                                // Add the ball sprite.
    let scoreLabel = SKLabelNode(fontNamed: "Helvetica-Bold")                  // A label and a variable to track score.
    var score = 0                                                              // Tracks the current score.
    let Block = SKSpriteNode(imageNamed: "Block")                              // Add the block sprite.
    let Smash_Ball = SKSpriteNode(imageNamed: "Smash_Ball")
    
    // This function runs once at the start of the game.
    override func didMove( to view: SKView) {
        backgroundColor = SKColor.black                                        // Background color of the scene is solid black.
        Ball.position = CGPoint(x: size.width/2, y: size.height/2)             // Configure how the ball sprite looks.
        Ball.zPosition = 1                                                     // Ensures that the ball is drawn above the background.
        addChild(Ball)                                                         // Add the ball sprite to the scene.
        
        let background = SKSpriteNode(imageNamed: "Country Background")        // Adding a sprite to represent background.
        background.position = CGPoint(x: size.width/2, y: size.height/2)       // Anchor the background image in the middle of the screen.
        background.size = self.frame.size                                      // Set the size of the background sprite to the screen size.
        background.zPosition = -1                                              // Ensures that the background is drawn under the ball sprite.
        addChild(background)                                                   // Add the background sprite to the scene.
        
        let actionWait = SKAction.wait(forDuration: 0.2)                       // Periodically spawn obstacles, and speed at which they spawn
        let actionSpawn = SKAction.run () {[weak self] in self?.spawnObstacles()}// Obstacles spawn.
        let actionSequence = SKAction.sequence ([actionWait, actionSpawn])     // The sequence where the blocks spawn.
        let actionObstacleRepeat = SKAction.repeatForever(actionSequence)      // Configures action sequence to repeat forever.
        run(actionObstacleRepeat)                                              // Now run start the sequence.
        
        scoreLabel.text = String(score)                                        // Add the heads-up display to show the score.
        scoreLabel.fontColor = SKColor.black                                   // Font color is made black.
        scoreLabel.fontSize = 96                                               // Font size is defined here.
        scoreLabel.zPosition = 150                                             // Makes sure the HUD is ontop of all the other nodes.
        scoreLabel.position = CGPoint(x: size.width - size.width/8, y: size.height - size.height/4)
        addChild(scoreLabel)                                                   // Add score label to the scene.
        
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
        let actionMove = SKAction.move(to: destination, duration: 0.5)           // Create an action.
        Ball.run(actionMove)                                                   // Tell the ball sprite to move.
    }
    // Spawns the blocks
    func spawnObstacles(){                                                     // Method to spawn multiple obstacles for the ball to dodge.
        let obstacle = SKSpriteNode(imageNamed: "Block")                       // Create instance of the obstacle.
        obstacle.setScale(6)                                                   // Set the size of the obstacle.
        let horizontalPosition = CGFloat(arc4random_uniform(UInt32(size.width)))// Define the starting position of the obstacle. (random)
        let verticalPosition = size.height + obstacle.size.height * 2          // Make sure obstacle is starting off screen.
        let startingPosition = CGPoint(x: horizontalPosition, y: verticalPosition)// Define the starting position for the obstacle.
        obstacle.position = startingPosition                                   // Set the starting position.
        obstacle.zPosition = 2                                                 // Ensure the block sprite spawns above the background and ball.
        obstacle.name = "obstacle"                                             // Define the name of the obstacle.
        addChild(obstacle)                                                     // Add the obstacle sprite to the scene.
        
        // Move the obstacle.
        let endingPosition = CGPoint(x: horizontalPosition, y: 0 - obstacle.size.height)
        let actionMove = SKAction.move(to: endingPosition, duration: 5)        // Obstacle moves to end position defined<.
        let actionRemove = SKAction.removeFromParent()                         // This will remove the obstacle from the scene.
        let actionSequence = SKAction.sequence([actionMove, actionRemove])     // Tells what actions to run and in which order.
        obstacle.run(actionSequence, withKey: "obstacleFalling")               // instead of running a single action, it run the sequence.
        
        
        // Spawns the smash ball
        let secondObstacle = SKSpriteNode(imageNamed: "Smash_Ball")
        secondObstacle.setScale(0.2)
        let horizontalPosition2 = CGFloat(arc4random_uniform(UInt32(size.width)))
        let verticalPosition2 = size.height + secondObstacle.size.height * 2
        let startingPosition2 = CGPoint(x: horizontalPosition2, y: verticalPosition2)
        secondObstacle.position = startingPosition2
        secondObstacle.zPosition = 3
        secondObstacle.name = "secondObstacle"
        addChild(secondObstacle)
        
        let endingPosition2 = CGPoint(x: horizontalPosition2, y: 0 - secondObstacle.size.height)
        let actionMove2 = SKAction.move(to: endingPosition2, duration: 5)
        let actionRemove2 = SKAction.removeFromParent()
        let actionSequence2 = SKAction.sequence([actionMove2, actionRemove2])
        secondObstacle.run(actionSequence2, withKey: "obstacleFalling")
    }
    func checkCollisions() {                                                   // Function checks for collisions between the ball and the block
        var hitObstacles : [SKSpriteNode] = []                                 // Array that will contain all of the obstacles hitting the ball
        enumerateChildNodes(withName: "obstacle", using: {                     // Find all of the obstacles colliding with the ball.
            node, _ in
            let obstacle = node as! SKSpriteNode                               // Get reference to the node that was found with the name obsta.
            if obstacle.frame.insetBy(dx: 10, dy: 10).intersects(self.Ball.frame.insetBy(dx: 10, dy: 10)) {// check to see if they intersect.
                hitObstacles.append(obstacle)                                  // If the obstacles hits the ball.
            }
        })
        for obstacle in hitObstacles {                                         // loop over all of the obstacles colliding and deal with them.
            ballHit(by: obstacle)                                              // Call function to get rid of the obstacle.
            
        }
    }
    
    
    func ballHit (by obstacle: SKSpriteNode) {                                 // This function removes the block from the game.
        score -= 1                                                             // Reduce the score.
        scoreLabel.text = String(score)                                        // Update the score label.
        obstacle.removeAction(forKey: "obstacleFalling")                       // Stop the action.
        obstacle.removeFromParent()
        
        if score == -20 {
            let gameOverScene = GameOverScene(size: size)
            let reveal = SKTransition.doorsCloseHorizontal(withDuration: 1.0)
            view?.presentScene(gameOverScene, transition: reveal)
        }
    
    }
}
