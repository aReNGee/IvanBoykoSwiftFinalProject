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
    
    let background = SKSpriteNode(imageNamed: "mainMenuREMIX")
    
    //buttons
    var playButton1 : UIButton!
    var playButton2 : UIButton!
    var gameType1 : UILabel!
    var gameType2 : UILabel!
    
    var animatedObject : AnimatedKid!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        //background image instantiation
        animatedObject = AnimatedKid(_position: CGPoint(x: size.width / 2, y: 360))
        
        addChild(background)
        addChild(animatedObject)
        //addChild(scoreText)
        //addChild(bigText)
        
        //setting the background to the center of the screen
        background.scale(to: CGSize(width: size.width/2.2, height: size.height))
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        
        scoreText.position = CGPoint(x: size.width / 3.25, y: 55)
        bigText.position = CGPoint(x: size.width / 2, y: size.height - 80)
        
        
        //setting the depth of the background to be at the back, always rendering first
        background.zPosition = -1
        
        playButton1 = UIButton(type: .system)
        playButton1.setImage(UIImage(named: "boy1"), for: .normal)
        playButton1.tintColor = .green
        view.addSubview(playButton1)
        playButton2 = UIButton(type: .system)
        playButton2.setImage(UIImage(named: "girl1"), for: .normal)
        playButton2.tintColor = .green
        view.addSubview(playButton2)
        
        gameType1 = UILabel()
        gameType1.text = "KID CRUSHER"
        view.addSubview(gameType1)
        gameType2 = UILabel()
        gameType2.text = "GAME MODE IN PROGRESS"
        view.addSubview(gameType2)
        
        playButton1.translatesAutoresizingMaskIntoConstraints = false
        playButton2.translatesAutoresizingMaskIntoConstraints = false
        gameType1.translatesAutoresizingMaskIntoConstraints = false
        gameType2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            playButton1.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            playButton1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            
            gameType1.topAnchor.constraint(equalTo: playButton1.topAnchor, constant: 10),
            gameType1.leadingAnchor.constraint(equalTo: playButton1.trailingAnchor, constant: 10),
            
            playButton2.topAnchor.constraint(equalTo: playButton1.bottomAnchor, constant: 20),
            playButton2.leadingAnchor.constraint(equalTo: playButton1.leadingAnchor, constant: 0),
            
            gameType2.topAnchor.constraint(equalTo: playButton2.topAnchor, constant: 10),
            gameType2.leadingAnchor.constraint(equalTo: playButton2.trailingAnchor, constant: 10)

            ])
        
        
        //animations stuff
        animatedObject.Animate()
    }
    
    
    
    override func update(_ currentTime: TimeInterval)
    {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
        }
    }
    
    
    
}
