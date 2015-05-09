//
//  GameScene.swift
//  BashoJump
//
//  Created by 佐藤健一朗 on 2015/05/09.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //var motionManager : CMMotionManager!
    
    var blockManager : BlockManager!
    
    var charactor : Basho!
    
    var point: Int = 0
    
    var pointLabel : SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        initPhysicsWorld()
        setBackground()
        setBlocks()
        setCharactor()
    }

    func initPhysicsWorld() {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        self.physicsWorld.contactDelegate = self
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
        
        let highSroreLabel = SKLabelNode(fontNamed: "Hiragino Kaku Gothic ProN")
        highSroreLabel.text = "ハイスコア :0里"
        highSroreLabel.fontSize = 17
        highSroreLabel.fontColor = UIColor.whiteColor()
        highSroreLabel.position = CGPoint(x: 100, y: frameSprite.size.height - 30)
        highSroreLabel.zPosition = 7
        self.addChild(highSroreLabel)
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
        } else {
            point++
            pointLabel.text = "\(point)里"
        }
    }
    
    func isBelowFoor(contact:SKPhysicsContact) -> Bool {
        return (contact.bodyA.node is Floor || contact.bodyB.node is Floor)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        charactor.movePerFrame()
    }
}
