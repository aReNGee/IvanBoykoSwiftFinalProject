//
//  GameType.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 4/24/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation

protocol GameMode {
    func GameStart()
    func GameEnd()
}

class GameType : GameMode {
    var hasTimeLimit : Bool
    var hasScoreTarget : Bool
    var timeLimit : CFloat = 0.0
    var scoreTarget : CFloat = 0.0
    
    init() {
        hasTimeLimit = false
        hasScoreTarget = false
    }
    
    func GameStart() {
    
    }
    
    func GameEnd() {
        
    }
    
    

}

class KidCrusher : GameType {
    override init(){
        super.init()
        hasTimeLimit = false
        hasScoreTarget = false
    }
    
}
