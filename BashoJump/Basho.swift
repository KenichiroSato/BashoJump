//
//  Basho.swift
//  BashoJump
//
//  Created by 佐藤健一朗 on 2015/05/09.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class Basho : SKSpriteNode {
    
    static private let TEXTURE_UP = SKTexture(imageNamed: "up")
    
    static private let TEXTURE_DOWN = SKTexture(imageNamed: "down")
    
    
    init() {
        super.init(texture: Basho.TEXTURE_UP, color:nil, size: Basho.TEXTURE_UP.size())
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
}