//
//  Entity.swift
//  Ultimate_Tactical_Dungeon_Simulator_Extreme_Version_Game_Of_The_Semester_Edition_MK_1_v_1.0.0
//
//  Created by Joshua Hess on 2/14/18.
//  Copyright © 2018 Ephemerality. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

public class Entity {
    
    let Sprite:SKSpriteNode
    let Max_Health:Int
    var Health:Int
    let Attack:Int
    let Defense:Int
    
    
    init(sprite:SKSpriteNode, x:CGFloat, y: CGFloat) {
        Sprite = sprite
        Sprite.position = CGPoint(x:x,y:y)
        Max_Health = 100
        Health = Max_Health
        Attack = 10
        Defense = 10
    }
    init(sprite:SKSpriteNode, x:CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        Sprite = sprite
        Sprite.position = CGPoint(x:x,y:y)
        Sprite.scale(to: CGSize(width: w, height: h))
        Max_Health = 100
        Health = Max_Health
        Attack = 10
        Defense = 10
    }
    
    enum Relative : EnumCollection {
        case CENTER
        case NORTH
        case EAST
        case SOUTH
        case WEST
    }
    
    func Get_Bounds(pos:Relative)->(lower_left:CGPoint, upper_right:CGPoint) {
        var x0:CGFloat = 1
        var y0:CGFloat = 1
        var x1:CGFloat = 1
        var y1:CGFloat = 1
        
        switch pos {
            case Relative.CENTER:
                x0 = -1
                y0 = -1
                x1 = 1
                y1 = 1
                break
            case Relative.NORTH:
                x0 = -1
                y0 = 1
                x1 = 1
                y1 = 3
                break
            case Relative.EAST:
                x0 = 1
                y0 = -1
                x1 = 3
                y1 = 1
                break
            case Relative.SOUTH:
                x0 = -1
                y0 = -3
                x1 = 1
                y1 = -1
                break
            case Relative.WEST:
                x0 = -3
                y0 = -1
                x1 = -1
                y1 = 1
                break
        }
        
        let a = CGPoint(x:Sprite.position.x + ((Sprite.size.width / 2) * x0), y:Sprite.position.y + ((Sprite.size.height / 2) * y0))
        let b = CGPoint(x:Sprite.position.x + ((Sprite.size.width / 2) * x1), y:Sprite.position.y + ((Sprite.size.height / 2) * y1))
        return (a, b)
    }
    func Damage(Damage:Int)->Bool {
        let dead = Health - Damage <= 0
        Health = dead ? 0 : Health - Damage
        return dead
    }
    func Move(dir:Relative) {
        switch dir {
            case Relative.CENTER:
                break
            case Relative.NORTH:
                Sprite.position.y += Game.TILE_SIZE
                break
            case Relative.EAST:
                Sprite.position.x += Game.TILE_SIZE
                break
            case Relative.SOUTH:
                Sprite.position.y -= Game.TILE_SIZE
                break
            case Relative.WEST:
                Sprite.position.x -= Game.TILE_SIZE
                break
            }
    }
    
}

protocol EnumCollection : Hashable {}
extension EnumCollection {
    static func Cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }
}
