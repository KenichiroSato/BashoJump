//
//  BlockManager.swift
//  BashoJump
//
//  Created by 佐藤健一朗 on 2015/05/09.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class BlockManager {
    
    static private let NUMBER_OF_BLOCKS = 1000
    
    static private let MINIMUM_Y_GAP:CGFloat = 50
    
    let baseNode : SKNode
    
    init() {
        baseNode = SKNode()
        baseNode.zPosition = 2
    }
    
    func addBlocks(parentNode:SKNode) {
        var x:CGFloat = 0
        var y:CGFloat = 0
        
        for i in 0..<BlockManager.NUMBER_OF_BLOCKS {
            var randX = arc4random_uniform(UInt32(UIScreen.mainScreen().bounds.size.width))
            var randY = arc4random_uniform(100)
            x = CGFloat(randX)
            y += CGFloat(randY) + BlockManager.MINIMUM_Y_GAP
            let block = Block()
            block.position = CGPoint(x: x, y: y)
            baseNode.addChild(block)
        }
        parentNode.addChild(baseNode)
    }
    
    func move() {
        let move = SKAction.moveBy(CGVector(dx: 0, dy: -100), duration: 0.5)
        baseNode.runAction(move)
    }
}