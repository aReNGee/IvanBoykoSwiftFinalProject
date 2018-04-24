//
//  MenuScene.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 4/24/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class MenuScene: SKScene {

    lazy var scoreText: SKLabelNode = {
        var text = SKLabelNode(fontNamed: "Arial")
        text.fontSize = CGFloat(75)
        text.zPosition = 2
        text.color = SKColor.white
        text.horizontalAlignmentMode = .left
        text.verticalAlignmentMode = .bottom
        text.text = "Score:"
        return text
    }()
    
    lazy var bigText: SKLabelNode = {
        var text = SKLabelNode(fontNamed: "Arial")
        text.fontSize = CGFloat(40)
        text.zPosition = 2
        text.color = SKColor.white
        text.horizontalAlignmentMode = .center
        text.verticalAlignmentMode = .bottom
        text.text = "placeholder"
        return text
    }()
    
    let background = SKSpriteNode(imageNamed: "bg_kids")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        //background image instantiation
        
        addChild(background)
        
        addChild(scoreText)
        addChild(bigText)
        
        //setting the background to the center of the screen
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.scale(to: CGSize(width: size.width, height: size.height))
        
        scoreText.position = CGPoint(x: size.width / 3.25, y: 55)
        bigText.position = CGPoint(x: size.width / 2, y: size.height - 80)
        
        
        //setting the depth of the background to be at the back, always rendering first
        background.zPosition = -1
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval)
    {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
        }
    }
    
    
    
}
