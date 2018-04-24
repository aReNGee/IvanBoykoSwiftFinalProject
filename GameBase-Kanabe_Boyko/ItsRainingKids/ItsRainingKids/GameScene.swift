//
//  GameScene.swift
//  ItsRainingKids
//
//  Created by Kanabe Lucas A. on 2/28/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //variable that will hold our falling objects
    var kids: [Kid] = []
    var _trampoline = Trampoline()
    var score = Int(0)
    lazy var scoreText: SKLabelNode = {
        var text = SKLabelNode(fontNamed: "Arial")
        text.fontSize = CGFloat(75)
        text.zPosition = 2
        text.color = SKColor.white
        text.horizontalAlignmentMode = .left
        text.verticalAlignmentMode = .bottom
        text.text = "Score: \(score)"
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
    
    var sManager : SpawnManager?
    
     let background = SKSpriteNode(imageNamed: "bg_kids")
    
    var gManger : GameManager?
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        //background image instantiation
        
        addChild(background)
        addChild(_trampoline)
        addChild(scoreText)
        addChild(bigText)
        
        //setting the background to the center of the screen
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.scale(to: CGSize(width: size.width, height: size.height))
        _trampoline.position = CGPoint(x: size.width / 2, y: size.height / 7)
        _trampoline.zPosition = -0.5
        scoreText.position = CGPoint(x: size.width / 3.25, y: 55)
       
        
        //setting the depth of the background to be at the back, always rendering first
        background.zPosition = -1
        
        //initializing spawn manager
        sManager = SpawnManager(sRef: self)
        gManger = GameManager()
        var temp = gManger!.gameType?.GameStart()
        print(temp!)
        //temp = "test"
        
        let othertemp = temp!
        bigText.text = othertemp
        
        
        
        bigText.position = CGPoint(x: size.width / 2, y: size.height - 80)

        Timer.scheduledTimer(timeInterval: SetGameSpeed(), target: self, selector: #selector(self.CreateNewKid), userInfo: nil, repeats: true)
        
    }
    
    //sets the game speed based on the game type, if possible
    func SetGameSpeed() -> Double {
        guard let gSpeed = gManger?.gameType?.gameSpeed else {
            return 0.5
        }
        return gSpeed
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        var markedForDeletion: [Int] = []
        var counter = Int(0)
        for k in kids {
            k.updateKids()
            if (k.deleteIfOffscreen()){
                markedForDeletion.append(counter)
            }
            counter += 1
        }
        
        for i in markedForDeletion {
            kids[i].removeFromParent()
            kids.remove(at: i)
            score -= 1 //lose one point for each kid you miss
        }
        print("score is " , score)
        scoreText.text = "Score: \(score)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touchAvailable = true
        for touch in touches {
            var markedForDeletion: [Int] = []
             var counter = Int(0)
            
            debugPrint(touch.location(in: self))
            for k in kids {
                if (touchAvailable) {
                    if (k.touchInsideBounds(_position: touch.location(in: self))){
                        markedForDeletion.append(counter)
                        touchAvailable = false
                        score += 1 //get a point for clicking on a kid
                        spawnParticleEffect(_position: touch.location(in: self))
                    }
                    counter += 1
                }
            }
            
            //_trampoline.handleMovement(_position: touch.location(in: self))
            for i in markedForDeletion {
                kids[i].removeFromParent()
                kids.remove(at: i)
            }
        }
    }
    
    @objc func CreateNewKid(){
        //print("SPAWNING")
        kids.append(sManager!.spawnKid())
        kids.last!.speedMultiplier(mod: score)
        addChild(kids.last!)
        //kids.last!.position = CGPoint(x: size.width / 2, y: size.height / 2)
    }
   
    func spawnParticleEffect(_position: CGPoint){
        let particle = SKEmitterNode(fileNamed: "Explode.sks")
        particle?.name = "test"
        particle?.position = _position
        particle?.targetNode = self
        addChild(particle!)
    }
    
}
