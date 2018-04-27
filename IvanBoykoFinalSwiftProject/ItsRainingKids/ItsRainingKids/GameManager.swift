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

    
    init(gType: Int?){ //when GameManager is created, set the desired game type
        guard gType == 1 else {
            gameType = EndlessKids(manager: self)
            return
        }
        gameType = KidCrusher(manager: self)
    }
    
    func getGameSpeed() -> Double { //simple geter for game speed with default value
        guard let gSpeed = gameType?.gameSpeed else {
            return 0.5
        }
        return gSpeed
    }
    
}
