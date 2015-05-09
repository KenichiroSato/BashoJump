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
    
    var isGameOver = false
    
    let gameOverSprite = SKSpriteNode(imageNamed: "gameover")
    
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
        
        let scoreFrame = SKSpriteNode(imageNamed: "score")
        scoreFrame.anchorPoint = CGPoint(x: 1, y: 1)
        scoreFrame.position = CGPoint(x: frameSprite.size.width - 10,
            y: frameSprite.size.height - 10)
        scoreFrame.zPosition = 6
        self.addChild(scoreFrame)

        gameOverSprite.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        gameOverSprite.hidden = true
        gameOverSprite.zPosition = 8
        self.addChild(gameOverSprite)
    }
    
    func setBlocks() {
        blockManager = BlockManager()
        blockManager.addBlocks(self)
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
            //game over
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
            if (isGameOver) {
                restartGame()
            }
        }
    }
    
    private func restartGame() {
        scoreManager.resetPoint()
        removeAllChildren()
        
        isGameOver = false
        self.paused = false
        startGame()
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        charactor.movePerFrame()
    }
    
    private func gameOver() {
        isGameOver = true
        self.paused = true
        gameOverSprite.hidden = false
        charactor.gameOver()
        scoreManager.storeHighScore()
    }
}
