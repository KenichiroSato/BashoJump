//
//  GameScene.swift
//  BashoJump
//
//  Created by 佐藤健一朗 on 2015/05/09.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var blockManager : BlockManager!
    
    var charactor : Basho!
    
    var scoreManager : ScoreManager!
    
    override func didMoveToView(view: SKView) {
        initPhysicsWorld()
        startGame()
    }

    func initPhysicsWorld() {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        self.physicsWorld.contactDelegate = self
    }
    
    func startGame() {
        setScore()
        setBackground()
        setBlocks()
        setCharactor()
    }
    
    func setScore() {
        scoreManager = ScoreManager(parent: self)
        scoreManager.updatePointLabel()
        scoreManager.updateHighScoreLabel()
    }
    
    func setBackground() {
        let bgSprite = Background()
        self.addChild(bgSprite)
        
        let floor = Floor()
        self.addChild(floor)
        
        let frameSprite = SKSpriteNode(imageNamed: "frame")
        frameSprite.anchorPoint = CGPoint(x: 0, y: 0)
        frameSprite.zPosition = 5
        frameSprite.size = self.size
        self.addChild(frameSprite)
    }
    
    func setBlocks() {
        blockManager = BlockManager(parentNode: self)
        blockManager.addInitialBlocks()
    }
    
    func setCharactor() {
        charactor = Basho()
        self.addChild(charactor)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if (charactor.contactEnabled) {
            blockManager.move()
            charactor.jump()
        }

        if (isBelowFoor(contact)) {
            gameOver()
        } else {
            scoreManager.addPoint()
        }
    }
    
    func isBelowFoor(contact:SKPhysicsContact) -> Bool {
        return (contact.bodyA.node is Floor || contact.bodyB.node is Floor)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            if (isGameOver()) {
                restartGame()
            }
        }
    }
    
    private func restartGame() {
        scoreManager.resetPoint()
        removeAllChildren()
        
        self.paused = false
        startGame()
    }
   
    private func isGameOver() -> Bool {
        return self.paused
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        charactor.movePerFrame()
    }
    
    private func gameOver() {
        showGameOverLabel()
        self.paused = true
        charactor.gameOver()
        scoreManager.storeHighScore()
    }
    
    private func showGameOverLabel() {
        let gameOverSprite = SKSpriteNode(imageNamed: "gameover")
        gameOverSprite.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        gameOverSprite.zPosition = 8
        self.addChild(gameOverSprite)
    }
}
