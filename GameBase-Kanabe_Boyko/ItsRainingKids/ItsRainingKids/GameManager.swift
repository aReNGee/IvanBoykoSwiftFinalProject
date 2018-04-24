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
    weak var gameType : GameType?
    
    init() {
        gameType = KidCrusher(manager: self)
    }
    
}
