//
//  Map.swift
//  Ultimate_Tactical_Dungeon_Simulator_Extreme_Version_Game_Of_The_Semester_Edition_MK_1_v_1.0.0
//
//  Created by Joshua Hess on 2/23/18.
//  Copyright © 2018 Ephemerality. All rights reserved.
//

import Foundation
import SpriteKit

class Map{
    // 64p nodes
    var Background:SKSpriteNode
    var Nodes = [[MapNode]]()
    let XSize:Int
    let YSize:Int
    
    init(background:SKSpriteNode, xSize:Int, ySize:Int){
        Background = background
        background.position = CGPoint(x: 32, y: 32)
        background.zPosition = 0
        XSize = xSize
        YSize = ySize
        InitNodes()
    }
    func ToPixelPrecision(tileX: Int, tileY: Int)->CGPoint {
        return CGPoint(x: tileX * 64, y: tileY * 64)
    }
    func ToTilePrecision(pos: CGPoint)->(tileX: Int, tileY: Int) {
        print("[ToTilePrecision] using \(pos) and getting (\(Int(pos.x / Game.TILE_SIZE)), \(Int(pos.y / Game.TILE_SIZE)))")
        return (tileX: Int(pos.x / Game.TILE_SIZE), tileY: Int(pos.y / Game.TILE_SIZE))
    }
    func ToTilePrecision(indexX: Int, indexY: Int)->(tileX: Int, tileY: Int) {
        return (tileX: indexX - (XSize / 2), tileY: indexY - (YSize / 2))
    }
    func ToIndexPrecision(tileX: Int, tileY: Int)->(indexX: Int, indexY: Int) {
        return (indexX: tileX + (XSize / 2), indexY: tileY + (YSize / 2))
        
    }
    func InitNodes(){
        for i in 0...XSize {
            var nodes = [MapNode]()
            for j in 0...YSize{
                let tile = ToTilePrecision(indexX: i, indexY: j)
                let pos = ToPixelPrecision(tileX: tile.tileX, tileY: tile.tileY)
                let node = MapNode(x:tile.tileX, y:tile.tileY, pos:pos)
                nodes.append(node)
            }
            Nodes.append(nodes)
        }
    }
    
    func findTile(tileX: Int,tileY: Int)->MapNode{
        var index = ToIndexPrecision(tileX: tileX, tileY: tileY)
        if index.indexX >= XSize || index.indexY >= YSize {
            print("[Warning][Map][FindTile] Out of bounds, return node at 0,0.")
            index = ToIndexPrecision(tileX: 0, tileY: 0)
            return Nodes[index.indexX][index.indexY]
        }
        print("[FindTile] Turned (\(tileX),\(tileY)) to (\(index.indexX),\(index.indexY))")
        return Nodes[index.indexX][index.indexY]
        
        
        
//        var checkedTileX = tileX
//        var checkedTileY = tileY
//        if((XSize/2)<tileX){
//            checkedTileX = XSize/2
//        }else if tileX<(0-XSize/2){
//            checkedTileX = 0-XSize/2
//        }
//        if((YSize/2)<tileY){
//            checkedTileY = YSize/2
//        }else if tileY<(0-YSize/2){
//            checkedTileY = 0-YSize/2
//        }
//        for nodeA in Nodes{
//            if nodeA[0].TileY == checkedTileY{
//                for node in nodeA{
//                    if (checkedTileX == node.TileX){
//                        //print("(Map)inputX:\(tileX),inputY:\(tileY))")
//                        //print("(Map)TileX:\(node.TileX),TileY:\(node.TileY))")
//                        return node
//                    }
//                }
//            }
//        }
//        //shouldn't make it this far...
//        return MapNode.init(x: 100, y: 100)
    }
    func findTile(location:CGPoint)->MapNode{
        let tile = ToTilePrecision(pos: location)
        return findTile(tileX: tile.tileX, tileY: tile.tileY)
        
//        let xPos = Int(location.x / 64)
//        let yPos = Int(location.y / 64)
////        let xPos = Int((location.x/64>=0) ? (location.x/64).rounded(.up) : (location.x/64).rounded(.down))
////        let yPos = Int((location.y/64>=0) ? (location.y/64).rounded(.up) : (location.y/64).rounded(.down))
//        return findTile(tileX:xPos,tileY:yPos)
    }
    
    func getNodeType(location:CGPoint) -> OccupiedType{
        return findTile(location: location).TileOc
    }
    
    
}

enum OccupiedType{
    case nothing, enemy, friend, blockedTile
}

class MapNode{
    
    var TileOc:OccupiedType;
    let TileX:Int
    let TileY:Int
    let Location:CGPoint
    init(x:Int, y:Int, pos: CGPoint, tileOccupiedBy tileOc:OccupiedType = OccupiedType.nothing){
        TileX=x
        TileY=y
        Location = pos
        TileOc = tileOc
        
    }
    
    
}
