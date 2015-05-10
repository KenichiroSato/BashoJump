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
    
    static private let NUM_OF_INITIAL_BLOCKS = 10
    
    static private let MINIMUM_Y_GAP:CGFloat = 50
    
    static private let MOVE_DISTANCE : CGFloat = 100
    
    let baseNode : SKNode
    
    var currentY : CGFloat = 0
    
    init(parentNode:SKNode) {
        baseNode = SKNode()
        baseNode.zPosition = 2
        parentNode.addChild(baseNode)
    }
    
    func addInitialBlocks() {
        for i in 0..<BlockManager.NUM_OF_INITIAL_BLOCKS {
            addBlock()
        }
    }
    
    func addBlock() {
        var randX = arc4random_uniform(UInt32(UIScreen.mainScreen().bounds.size.width))
        var randY = arc4random_uniform(100)
        currentY = currentY + CGFloat(randY) + BlockManager.MINIMUM_Y_GAP
        let x = CGFloat(randX)
        let block = Block(x: x, y: currentY)
        baseNode.addChild(block)
    }
    
    func move() {
        let move = SKAction.moveBy(CGVector(dx: 0,
            dy: -BlockManager.MOVE_DISTANCE), duration: 0.5)
        baseNode.runAction(move)
        currentY -= BlockManager.MOVE_DISTANCE
        addBlock()
    }
}