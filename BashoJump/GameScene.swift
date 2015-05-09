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
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
