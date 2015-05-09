//
//  GameScene.swift
//  BashoJump
//
//  Created by 佐藤健一朗 on 2015/05/09.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var motionManager : CMMotionManager!
    
    override func didMoveToView(view: SKView) {
        initPhysicsWorld()
        initMotionManager()
        setBackground()
        setBlocks()
        setCharactor()
    }

    func initPhysicsWorld() {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
        self.physicsWorld.contactDelegate = self
    }
    
    func initMotionManager() {
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.1 // get every 0.1 second
        let accelerometerHandler:CMAccelerometerHandler = {
            (data:CMAccelerometerData!, error:NSError!) -> Void in
            println("x:\(data.acceleration.x) y:\(data.acceleration.y) z:\(data.acceleration.z)")
        }
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: accelerometerHandler)
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
        
        let pointLabel = SKLabelNode(fontNamed: "Hiragino Kaku Gothic ProN")
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
        let blockManager = BlockManager()
        blockManager.addBlocks(self)
    }
    
    func setCharactor() {
        let charactor = Basho()
        self.addChild(charactor)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
