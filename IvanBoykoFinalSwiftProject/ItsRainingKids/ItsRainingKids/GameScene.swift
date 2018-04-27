//
//  GameScene.swift
//  ItsRainingKids
//
//  Created by Kanabe Lucas A. on 2/28/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//  Rewritten with permission by Ivan Boyko

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    ///variable initialization///
    
    //manager variables
    var sManager : SpawnManager?
    var gManger : GameManager?
    var desiredGameType : Int?
    
    //variable that will hold our objects
    var kids: [Kid] = []
    
    let background = SKSpriteNode(imageNamed: "bg_kids")
    
    //defined by game mode
    var timer : CFloat = 0
    var livesRemaining : Int = 0
    
    //gameplay variables
    var score = Int(0)
    var previousTime : TimeInterval = 0
    var gameOver = false;
    
    ///UI elements///
    
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
    
    lazy var rulesText: SKLabelNode = {
        var text = SKLabelNode(fontNamed: "Arial")
        text.fontSize = CGFloat(40)
        text.zPosition = 2
        text.color = SKColor.white
        text.horizontalAlignmentMode = .center
        text.verticalAlignmentMode = .bottom
        text.text = "placeholder"
        return text
    }()
    
    lazy var loseConditionText: SKLabelNode = {
        var text = SKLabelNode(fontNamed: "Arial")
        text.fontSize = CGFloat(40)
        text.zPosition = 2
        text.color = SKColor.white
        text.horizontalAlignmentMode = .left
        text.verticalAlignmentMode = .bottom
        text.text = "Lose Condition"
        return text
    }()
    
    lazy var gameOverText: SKLabelNode = {
        var text = SKLabelNode(fontNamed: "Arial")
        text.fontSize = CGFloat(100)
        text.zPosition = 2
        text.color = SKColor.white
        text.horizontalAlignmentMode = .center
        text.verticalAlignmentMode = .bottom
        text.text = "GAME OVER"
        return text
    }()
    
    ///Initialization///
    
    override func didMove(to view: SKView) {
        
        //initializing managers
        sManager = SpawnManager(sRef: self)
        gManger = GameManager(gType: desiredGameType)
        
        //setting up the background and UI
        addChild(background)
        backgroundColor = SKColor.black
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.scale(to: CGSize(width: size.width, height: size.height))
        background.zPosition = -1
        
        addChild(scoreText)
        scoreText.position = CGPoint(x: size.width / 3.25, y: 55)
        
        gameOverText.position = CGPoint(x: size.width/2, y: size.height/2)
        //game over text is not added to the scene until the game is over
        
        addChild(rulesText)
        rulesText.position = CGPoint(x: size.width / 2, y: size.height - 80)
        let temp = gManger!.gameType?.GameStart()
        print(temp!)
        //temp = "test"
        
        //let othertemp = temp!
        rulesText.text = temp!

        addChild(loseConditionText)
        loseConditionText.position = CGPoint(x: size.width/2, y: 55)
        
        ///setting up the game rules///
        
        //set the time limit, if the game mode has one
        if (gManger!.gameType!.hasTimeLimit){
            timer = gManger!.gameType!.timeLimit
        }
        //set the max lives, if the game mode uses them
        if (gManger!.gameType!.hasMaxLives){
            livesRemaining = gManger!.gameType!.maxLives
        }
        
        //timed function that spawns kids on a a regular interval (speed varies by game type)
        Timer.scheduledTimer(timeInterval: gManger!.GetGameSpeed(), target: self, selector: #selector(self.CreateNewKid), userInfo: nil, repeats: true)
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        if (!gameOver){ //if the game is running
            
            var markedForDeletion: [Int] = []
            var counter = Int(0)
            for k in kids {
                k.updateKids() //update objets, then mark them for deletion if they're offscreen
                if (k.deleteIfOffscreen()){
                    markedForDeletion.append(counter)
                }
                counter += 1
            }
            
            for i in markedForDeletion {
                kids[i].removeFromParent()
                kids.remove(at: i)
                score -= 1 //lose one point for each kid you miss
                if (gManger!.gameType!.hasMaxLives){
                    livesRemaining -= 1
                }
            }

            scoreText.text = "Score: \(score)"
            
            //check the time limit if we have one
            if (gManger!.gameType!.hasTimeLimit){
                //if this is the first time we're running this, we will have no previous time
                if (previousTime != 0){
                    //calculate the time difference
                    timer -= CFloat(currentTime - previousTime)
                    loseConditionText.text = "Time Left: \(timer)"
                    if (timer <= 0){
                        //game over
                        if (!gameOver){
                            addChild(gameOverText)
                            gameOver = true
                        }
                    }
                }
                
                previousTime = currentTime
                
            }
            
            //check how many lives are remaining, if we have them
            if (gManger!.gameType!.hasMaxLives){
                loseConditionText.text = "Lives Remaining: \(livesRemaining)"
                if (livesRemaining <= 0){
                    //game over
                    if (!gameOver){
                        addChild(gameOverText)
                        gameOver = true
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if (!gameOver){ //if the game is running
                var touchAvailable = true //only one kid can be tapped in a single touch
                var markedForDeletion: [Int] = []
                var counter = Int(0)

                for k in kids {
                    if (touchAvailable) { //iterates through the kids and checks if its tapped on their location
                        if (k.touchInsideBounds(_position: touch.location(in: self))){
                            markedForDeletion.append(counter)
                            touchAvailable = false
                            score += 1 //get a point for clicking on a kid
                            spawnParticleEffect(_position: touch.location(in: self))
                        }
                        counter += 1
                    }
                }

                for i in markedForDeletion {
                    kids[i].removeFromParent()
                    kids.remove(at: i)
                }
            }
            else {
                //return to the title screen
                let scene = MenuScene(size: CGSize(width: 2048, height: 1536))
                scene.scaleMode = .aspectFill
                let skView = self.view as! SKView
                skView.presentScene(scene)
            }
        }
    }
    
    //function that creates a new kid. Mostly handled in SpawnManger
    @objc func CreateNewKid(){
        if (!gameOver){
            kids.append(sManager!.spawnKid())
            kids.last!.speedMultiplier(mod: score)
            addChild(kids.last!)
        }
    }
   
    //function that spawns explosion particle effects at a specific location
    func spawnParticleEffect(_position: CGPoint){
        let particle = SKEmitterNode(fileNamed: "Explode.sks")
        particle?.name = "test"
        particle?.position = _position
        particle?.targetNode = self
        addChild(particle!)
    }
    
}
