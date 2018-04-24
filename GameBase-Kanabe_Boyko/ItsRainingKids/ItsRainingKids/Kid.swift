//
//  Kid.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 3/14/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import SpriteKit

enum KidType {
    case Kid1
    case Kid2
    case Kid3
    case Kid4
    case Kid5
    
    init?(value: Int) {
        switch value {
        case 0:
            self = KidType.Kid1
        case 1:
            self = KidType.Kid2
        case 2:
            self = KidType.Kid3
        case 3:
            self = KidType.Kid4
        case 4:
            self = KidType.Kid5
        default:
            return nil
        }
    }
    
    var speed: CGFloat{
        switch self {
        case .Kid1:
            return 12
        case .Kid2:
            return 7
        case .Kid3:
            return 8
        case .Kid4:
            return 6
        case .Kid5:
            return 10
        default:
            return 14
        }
    }
    
    var imageName: String {
        switch self {
        case .Kid1:
            return "boy1"
        case .Kid2:
            return "boy2"
        case .Kid3:
            return "boy3"
        case .Kid4:
            return "girl1"
        case .Kid5:
            return "girl2"
        default:
            return "boy1"
        }
    }
    
}

class Kid: SKSpriteNode
{
    var type: KidType
    
    var movementSpeed = CGPoint(x: 0, y:0)
    
    var collided = Bool(false);
    
    var topOfScreen = CGPoint(x:0, y:0)
    
    
    
    
    init(KidType: KidType) {
        type = KidType
        
        let texture = SKTexture.init(imageNamed: type.imageName)
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width*3, height: texture.size().height*3))
        speed = type.speed
        zRotation = CGFloat(arc4random_uniform(360))
        movementSpeed = CGPoint(x: cos(zRotation * CGFloat(M_PI) / 180), y: sin(zRotation * CGFloat(M_PI) / 180))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateKids(){
        position = CGPoint (x: position.x + (speed * movementSpeed.x), y: position.y + (speed * movementSpeed.y))
        
    }
    
    func reverseDirection() -> Bool {
        if (!collided){
            collided = true;
            movementSpeed = CGPoint(x: movementSpeed.x * -1, y: movementSpeed.y * -1);
            return true
        } else {
            return false
        }
    }
    
    func deleteIfOffscreen() -> Bool {
        if (collided && position.y > topOfScreen.y){
            return true
        }
        return false
    }
    
    func speedMultiplier(mod: Int){
        if (mod > 10){
            let newMod = mod / 10
            speed *= CGFloat(newMod)
        }
    }
    
    //checks if the player touched within the bounds of the sprite
    func touchInsideBounds(_position: CGPoint) -> Bool {
        if (_position.y < position.y + size.height/2 && _position.y > position.y - size.height/2) {
            if (_position.x < position.x + size.width/2 && _position.x > position.x - size.width/2) {
                return true
            }
        }
        return false
    }
    
}
