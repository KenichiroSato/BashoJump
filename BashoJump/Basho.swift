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
    
    static private let TEXTURE = SKTexture(imageNamed: "up")
    
    
    init() {
        super.init(texture: Basho.TEXTURE, color:nil, size: Basho.TEXTURE.size())
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
}