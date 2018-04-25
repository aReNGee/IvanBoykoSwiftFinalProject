//
//  GameType.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 4/24/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import GameplayKit

protocol GameMode {
    func GameStart() -> String
    func GameEnd(textbox: SKLabelNode)
}

class GameType : GameMode {
    var hasTimeLimit : Bool
    var hasMaxLives : Bool
    var timeLimit : CFloat = 0.0
    var maxLives : Int = 0
    var instructions = "test"
    var congratulations = ""
    var gameSpeed = 0.5
    
    weak var gManager : GameManager?
    
    init(manager: GameManager?) {
        hasTimeLimit = false
        hasMaxLives = false
        gManager = manager
    }
    
    func GameStart() -> String{
        return instructions
    }
    
    func GameEnd(textbox: SKLabelNode) {
        textbox.text = congratulations
    }
    
    

}

class KidCrusher : GameType {
    
    override init(manager: GameManager?){
        super.init(manager: manager)
        hasTimeLimit = true
        hasMaxLives = false
        timeLimit = 60.0
        gameSpeed = 0.3
        instructions = "Crush as many kids as you can in sixty seconds!"
        congratulations = "You crushed those kids! "
    }
    override func GameEnd(textbox: SKLabelNode) {
        textbox.text = congratulations + "Can you crush even more next time?"
    }
}

class EndlessKids : GameType {
    
    override init(manager: GameManager?){
        super.init(manager: manager)
        hasTimeLimit = false
        hasMaxLives = true
        maxLives = 3
        gameSpeed = 0.8
        instructions = "Crush kids until you miss 3!"
        congratulations = "You crushed those kids! "
    }
    override func GameEnd(textbox: SKLabelNode) {
        textbox.text = congratulations + "Can you crush even more next time?"
    }
}
