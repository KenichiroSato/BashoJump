//
//  Basho.swift
//  BashoJump
//
//  Created by 佐藤健一朗 on 2015/05/09.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion

public class Basho : SKSpriteNode {
    
    static private let TEXTURE_UP = SKTexture(imageNamed: "up")
    
    static private let TEXTURE_DOWN = SKTexture(imageNamed: "down")
    
    static private let TEXTURE_MISS = SKTexture(imageNamed: "miss")
    
    static private let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
    
    private let motionManager : CMMotionManager
    
    private(set) var contactEnabled = true
    
    private var previousY : CGFloat = 0
    
    private var moveDeltaX : CGFloat = 0
    
    init() {
        motionManager = CMMotionManager()
        super.init(texture: Basho.TEXTURE_UP, color:nil, size: Basho.TEXTURE_UP.size())

        motionManager.accelerometerUpdateInterval = 0.1 // get every 0.1 second
        let accelerometerHandler:CMAccelerometerHandler = {
            (data:CMAccelerometerData!, error:NSError!) -> Void in
            self.moveDeltaX = CGFloat(data.acceleration.x * 20)
        }
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: accelerometerHandler)

        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.position = CGPoint(x: 160, y: 100)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(2,2))
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.allowsRotation = false
        
        //set Initial Verocity
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
        self.zPosition = 3
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func jump() {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 300)
        let changeTexture = SKAction.animateWithTextures([Basho.TEXTURE_UP, Basho.TEXTURE_DOWN], timePerFrame: 0.4)
        self.runAction(changeTexture)
    }
    
    func movePerFrame() {
        self.position = CGPoint(x: self.position.x + moveDeltaX, y: self.position.y)
        
        if (self.position.x < 0) {
            self.position.x = Basho.SCREEN_WIDTH
        } else if (self.position.x > Basho.SCREEN_WIDTH) {
            self.position.x = 0
        }
        
        if (isJumping()) {
            disableContact()
        } else {
            enableContact()
        }
        previousY = self.position.y
    }
    
    private func isJumping() -> Bool {
        return self.position.y > previousY
    }
    
    private func enableContact() {
        contactEnabled = true
        physicsBody?.collisionBitMask = 1
        physicsBody?.contactTestBitMask = 1
    }
    
    private func disableContact() {
        contactEnabled = false
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = 0
    }
    
    func gameOver() {
        self.texture = Basho.TEXTURE_MISS
    }
}