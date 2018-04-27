//
//  KidFactory.swift
//  ItsRainingKids
//
//  Created by Boyko Ivan on 3/14/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import Foundation
import SpriteKit

class KidFactory {
    
    private func GenerateKid(_ type : KidType) -> Kid {
        
        switch type {
        case .Kid1:
            return Kid(KidType: .Kid1)
        case .Kid2:
            return Kid(KidType: .Kid2)
        case .Kid3:
            return Kid(KidType: .Kid3)
        case .Kid4:
            return Kid(KidType: .Kid4)
        case .Kid5:
            return Kid(KidType: .Kid5)
        default:
            //fatalerror()
            return Kid(KidType: .Kid1)
        }
    }
    
    func createKid(specificType: KidType?) -> Kid {
        //if we aren't given a specific kind of kid to make, generate a random one
        guard let sType = specificType else { 
            let rand = Int(arc4random_uniform(5))
            let randKidType = KidType(value: rand)!
            return GenerateKid(randKidType)
        }
        
        return GenerateKid(sType)
    }
    
}
