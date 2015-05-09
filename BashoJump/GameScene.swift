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
    
    var point: Int = 0
    
    var pointLabel : SKLabelNode!
    
    var highScoreLabel : SKLabelNode!
    
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
        setBackground()
        setBlocks()
        setCharactor()
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
        
        pointLabel = SKLabelNode(fontNamed: "Hiragino Kaku Gothic ProN")
        pointLabel.text = "0里"
        pointLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        pointLabel.fontSize = 20
        pointLabel.position = CGPoint(x: scoreFrame.position.x - 50, y: scoreFrame.position.y-25)
        pointLabel.zPosition = 7
        self.addChild(pointLabel)
        
        highScoreLabel = SKLabelNode(fontNamed: "Hiragino Kaku Gothic ProN")
        var highScore = userDefaults.integerForKey("HIGHSCORE")
        highScoreLabel.text = "ハイスコア :\(highScore)里"
        highScoreLabel.fontSize = 17
        highScoreLabel.fontColor = UIColor.whiteColor()
        highScoreLabel.position = CGPoint(x: 100, y: frameSprite.size.height - 30)
        highScoreLabel.zPosition = 7
        self.addChild(highScoreLabel)
        
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
            point++
            pointLabel.text = "\(point)里"
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
        point = 0
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
        storeHighScore()
    }
    
    private func storeHighScore() {
        var hiscore:Int = userDefaults.integerForKey("HIGHSCORE")
        
        if (point > hiscore) {
            userDefaults.setInteger(point, forKey: "HIGHSCORE")
            userDefaults.synchronize()
            highScoreLabel.text = "ハイスコア :\(point)里"
        }
    }
}
