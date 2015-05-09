//
//  Background.swift
//  BashoJump
//
//  Created by 佐藤健一朗 on 2015/05/09.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class Background : SKSpriteNode {
    
    static private let TEXTURE = SKTexture(imageNamed: "background")
    
    init() {
        super.init(texture: Background.TEXTURE, color:nil, size: Background.TEXTURE.size())
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.zPosition = 1
        self.size = self.size
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}