//
//  GameManager.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 4/24/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation

class GameManager
{
    var gameType : GameType?
    
    init() {
        gameType = KidCrusher(manager: self)
    }
    
    init(gType: Int?){
        guard gType == 1 else {
            gameType = EndlessKids(manager: self)
            return
        }
        gameType = KidCrusher(manager: self)
    }
    
    func GetGameSpeed() -> Double {
        guard let gSpeed = gameType?.gameSpeed else {
            return 0.5
        }
        return gSpeed
    }
    
}
