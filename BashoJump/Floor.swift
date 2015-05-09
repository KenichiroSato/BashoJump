//
//  Floor.swift
//  BashoJump
//
//  Created by 佐藤健一朗 on 2015/05/09.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class Floor : SKSpriteNode {
    

    init() {
        super.init(texture: nil, color: nil, size: CGSizeMake(0, 0))
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: 0, y: 40)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(640,10))
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.dynamic = false
        
        self.zPosition = 4
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}