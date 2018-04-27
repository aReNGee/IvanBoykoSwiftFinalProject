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

    
    let background = SKSpriteNode(imageNamed: "mainMenuREMIX")
    
    //UI Elements
    var playButton1 : UIButton!
    var playButton2 : UIButton!
    var gameType1 : UILabel!
    var gameType2 : UILabel!
    
    //fancy animated menu scren item
    var animatedObject : AnimatedKid!
    
    override func didMove(to view: SKView) {
        //setting up background
        backgroundColor = SKColor.black
        background.scale(to: CGSize(width: size.width/2.2, height: size.height))
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        //animated title screen character
        animatedObject = AnimatedKid(_position: CGPoint(x: size.width / 2, y: 300))
        addChild(animatedObject)
        
        //button setup
        playButton1 = UIButton(type: .system)
        playButton1.setImage(UIImage(named: "boy1"), for: .normal)
        playButton1.tintColor = .green
        playButton1.addTarget(self, action: #selector(changeScene1), for: .touchUpInside)
        view.addSubview(playButton1)
        
        playButton2 = UIButton(type: .system)
        playButton2.setImage(UIImage(named: "girl1"), for: .normal)
        playButton2.tintColor = .green
        playButton2.addTarget(self, action: #selector(changeScene2), for: .touchUpInside)
        view.addSubview(playButton2)
        
        //UI Setup - button labels
        gameType1 = UILabel()
        gameType1.text = "KID CRUSHER"
        view.addSubview(gameType1)
        gameType2 = UILabel()
        gameType2.text = "ENDLESS MODE"
        view.addSubview(gameType2)
        
        
        //constraining buttons onto the screen
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
        
        
        //finally, tell the animated object to begin animating
        animatedObject.Animate()
    }
    
    //workaround for not passing paramaters by selector
    @objc func changeScene1(){
        generateScene(gameType: 1)
    }
    
    @objc func changeScene2(){
        generateScene(gameType: 2)
    }
    
    //creates and navigates to a game scene with the desired game type
    func generateScene(gameType: Int){
        let scene = GameScene(size: CGSize(width: 2048, height: 1536))
        scene.scaleMode = .aspectFill
        playButton1.removeFromSuperview()
        playButton2.removeFromSuperview()
        gameType1.removeFromSuperview()
        gameType2.removeFromSuperview()
        
        let gType = gameType
        
        scene.desiredGameType = gType
        let skView = self.view as! SKView
        skView.presentScene(scene)
    }
    
    
}
