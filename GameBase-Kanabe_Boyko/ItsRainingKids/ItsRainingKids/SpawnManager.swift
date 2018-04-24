//
//  SpawnManager.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 3/14/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import SpriteKit

class SpawnManager
{
    weak var sceneRef: GameScene?
    var spawnLocation: CGPoint
    var standardDeviation: UInt32
    
    let FactoryKid = KidFactory()
    
    init(sRef: GameScene) {
        sceneRef = sRef
        spawnLocation = CGPoint(x: sceneRef!.size.width/2, y: sceneRef!.size.height/2)
        standardDeviation = UInt32(sceneRef!.size.width/4 - sceneRef!.size.width/10)
        //print(standardDeviation)
    }
    
    func spawnKid() -> Kid{
        let newKid = FactoryKid.createKid(specificType: nil)
        //newKid.position = CGPoint(x: CGFloat(rand), y:spawnLocation.y)
        newKid.position = CGPoint(x: spawnLocation.x, y: spawnLocation.y)
        //newKid.topOfScreen.y = newKid.position.y + 50
        return newKid
    }
    
}
