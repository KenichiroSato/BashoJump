//
//  ScoreManager.swift
//  BashoJump
//
//  Created by 佐藤健一朗 on 2015/05/09.
//  Copyright (c) 2015年 Kenichiro Sato. All rights reserved.
//

import Foundation
import SpriteKit

public class ScoreManager {
    
    private static let KEY_HIGHSCORE = "HIGHSCORE"
    
    private static let IMAGE_SCORE = "score"
    
    private static let FONT_HIRAGINO = "Hiragino Kaku Gothic ProN"
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var point: Int = 0
    
    var pointLabel : SKLabelNode
    
    var highScoreLabel : SKLabelNode
    
    init(parent:SKScene) {
        let scoreFrame = SKSpriteNode(imageNamed: ScoreManager.IMAGE_SCORE)
        scoreFrame.anchorPoint = CGPoint(x: 1, y: 1)
        scoreFrame.position = CGPoint(x: parent.size.width - 10,
            y: parent.size.height - 10)
        scoreFrame.zPosition = 6
        parent.addChild(scoreFrame)
        
        pointLabel = SKLabelNode(fontNamed: ScoreManager.FONT_HIRAGINO)
        pointLabel.fontColor = UIColor.blackColor()
        pointLabel.fontSize = 20
        pointLabel.position = CGPoint(x: scoreFrame.position.x - 50,
            y: scoreFrame.position.y - 25)
        pointLabel.zPosition = 7
        parent.addChild(pointLabel)
        
        highScoreLabel = SKLabelNode(fontNamed: ScoreManager.FONT_HIRAGINO)
        highScoreLabel.fontSize = 17
        highScoreLabel.fontColor = UIColor.whiteColor()
        highScoreLabel.position = CGPoint(x: 100, y: parent.size.height - 30)
        highScoreLabel.zPosition = 7
        parent.addChild(highScoreLabel)
    }

    func addPoint() {
        point++
        updatePointLabel()
    }
    
    func resetPoint() {
        point = 0
        updatePointLabel()
    }
    
    func updatePointLabel() {
        pointLabel.text = "\(point)里"
    }
    
    func updateHighScoreLabel() {
        var highScore = userDefaults.integerForKey(ScoreManager.KEY_HIGHSCORE)
        highScoreLabel.text = "ハイスコア :\(highScore)里"
    }
    
    func storeHighScore() {
        var highScore = userDefaults.integerForKey(ScoreManager.KEY_HIGHSCORE)
        if (point > highScore) {
            userDefaults.setInteger(point, forKey: ScoreManager.KEY_HIGHSCORE)
            userDefaults.synchronize()
            updateHighScoreLabel()
        }

    }
}
