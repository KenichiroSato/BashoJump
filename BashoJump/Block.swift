//
//  Block.swift
//  BashoJump
//
//  Created by 佐藤健一朗 on 2015/05/09.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class Block : SKSpriteNode {
    
    static private let TEXTURE = SKTexture(imageNamed: "ground")
    
    static private let HIT_DETECT_SIZE = CGSizeMake(87, 2)
    
    init(x:CGFloat, y:CGFloat) {
        super.init(texture: Block.TEXTURE, color:nil, size: Block.TEXTURE.size())
        self.position = CGPoint(x: x, y: y)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: Block.HIT_DETECT_SIZE)
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.contactTestBitMask = 1
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.dynamic = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}