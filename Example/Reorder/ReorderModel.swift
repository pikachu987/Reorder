//
//  ReorderModel.swift
//  Example
//
//  Created by Gwanho Kim on 2019/12/11.
//  Copyright © 2019 Gwanho Kim. All rights reserved.
//

import UIKit

struct ReorderModel {
    var key: String
    var color: UIColor
    var canMove: Bool
    
    init(key: String, color: UIColor, canMove: Bool = true) {
        self.key = key
        self.color = color
        self.canMove = canMove
    }
    
    static var list: [ReorderModel] {
        return [
        ReorderModel(key: "0", color: UIColor(red: 248/255, green: 246/255, blue: 209/255, alpha: 1)),
        ReorderModel(key: "1", color: UIColor(red: 183/255, green: 217/255, blue: 242/255, alpha: 1)),
        ReorderModel(key: "2", color: UIColor(red: 243/255, green: 208/255, blue: 224/255, alpha: 1)),
        ReorderModel(key: "3", color: UIColor(red: 89/255, green: 133/255, blue: 185/255, alpha: 1)),
        ReorderModel(key: "4", color: UIColor(red: 156/255, green: 201/255, blue: 233/255, alpha: 1)),
        ReorderModel(key: "5", color: UIColor(red: 204/255, green: 212/255, blue: 192/255, alpha: 1)),
        ReorderModel(key: "6", color: UIColor(red: 231/255, green: 203/255, blue: 171/255, alpha: 1)),
        ReorderModel(key: "7", color: UIColor(red: 238/255, green: 186/255, blue: 179/255, alpha: 1)),
        ReorderModel(key: "8", color: UIColor(red: 245/255, green: 243/255, blue: 232/255, alpha: 1)),
        ReorderModel(key: "9", color: UIColor(red: 245/255, green: 226/255, blue: 228/255, alpha: 1)),
        ReorderModel(key: "10", color: UIColor(red: 244/255, green: 191/255, blue: 209/255, alpha: 1)),
        ReorderModel(key: "11", color: UIColor(red: 163/255, green: 205/255, blue: 206/255, alpha: 1)),
        ReorderModel(key: "12", color: UIColor(red: 229/255, green: 218/255, blue: 160/255, alpha: 1)),
        ReorderModel(key: "13", color: UIColor(red: 191/255, green: 181/255, blue: 197/255, alpha: 1)),
        ReorderModel(key: "14", color: UIColor(red: 229/255, green: 165/255, blue: 130/255, alpha: 1)),
        ReorderModel(key: "15", color: UIColor(red: 40/255, green: 139/255, blue: 129/255, alpha: 1)),
        ReorderModel(key: "16", color: UIColor(red: 155/255, green: 217/255, blue: 219/255, alpha: 1)),
        ReorderModel(key: "17", color: UIColor(red: 229/255, green: 219/255, blue: 217/255, alpha: 1)),
        ReorderModel(key: "18", color: UIColor(red: 154/255, green: 212/255, blue: 188/255, alpha: 1)),
        ReorderModel(key: "19", color: UIColor(red: 234/255, green: 151/255, blue: 172/255, alpha: 1)),
        ReorderModel(key: "20", color: UIColor(red: 198/255, green: 201/255, blue: 208/255, alpha: 1)),
        ReorderModel(key: "21", color: UIColor(red: 194/255, green: 77/255, blue: 109/255, alpha: 1)),
        ReorderModel(key: "22", color: UIColor(red: 228/255, green: 180/255, blue: 189/255, alpha: 1)),
        ReorderModel(key: "23", color: UIColor(red: 196/255, green: 117/255, blue: 132/255, alpha: 1)),
        ReorderModel(key: "24", color: UIColor(red: 214/255, green: 228/255, blue: 196/255, alpha: 1), canMove: false),
        ]
    }
    
    static var sectionList: [[ReorderModel]] {
        return [
        [
            ReorderModel(key: "0-0", color: UIColor(red: 248/255, green: 246/255, blue: 209/255, alpha: 1), canMove: false),
            ReorderModel(key: "0-1", color: UIColor(red: 183/255, green: 217/255, blue: 242/255, alpha: 1)),
            ReorderModel(key: "0-2", color: UIColor(red: 243/255, green: 208/255, blue: 224/255, alpha: 1)),
            ReorderModel(key: "0-3", color: UIColor(red: 89/255, green: 133/255, blue: 185/255, alpha: 1)),
            ReorderModel(key: "0-4", color: UIColor(red: 156/255, green: 201/255, blue: 233/255, alpha: 1)),
        ],
        [
            ReorderModel(key: "1-0", color: UIColor(red: 204/255, green: 212/255, blue: 192/255, alpha: 1), canMove: false),
            ReorderModel(key: "1-1", color: UIColor(red: 231/255, green: 203/255, blue: 171/255, alpha: 1)),
            ReorderModel(key: "1-2", color: UIColor(red: 238/255, green: 186/255, blue: 179/255, alpha: 1)),
            ReorderModel(key: "1-3", color: UIColor(red: 245/255, green: 243/255, blue: 232/255, alpha: 1)),
            ReorderModel(key: "1-4", color: UIColor(red: 245/255, green: 226/255, blue: 228/255, alpha: 1)),
            ReorderModel(key: "1-5", color: UIColor(red: 244/255, green: 191/255, blue: 209/255, alpha: 1)),
        ],
        [
            ReorderModel(key: "2-0", color: UIColor(red: 163/255, green: 205/255, blue: 206/255, alpha: 1)),
            ReorderModel(key: "2-1", color: UIColor(red: 229/255, green: 218/255, blue: 160/255, alpha: 1)),
            ReorderModel(key: "2-2", color: UIColor(red: 191/255, green: 181/255, blue: 197/255, alpha: 1)),
            ReorderModel(key: "2-3", color: UIColor(red: 229/255, green: 165/255, blue: 130/255, alpha: 1)),
            ReorderModel(key: "2-4", color: UIColor(red: 40/255, green: 139/255, blue: 129/255, alpha: 1)),
            ReorderModel(key: "2-5", color: UIColor(red: 155/255, green: 217/255, blue: 219/255, alpha: 1)),
            ReorderModel(key: "2-6", color: UIColor(red: 229/255, green: 219/255, blue: 217/255, alpha: 1)),
        ],
        [
            ReorderModel(key: "3-0", color: UIColor(red: 154/255, green: 212/255, blue: 188/255, alpha: 1)),
            ReorderModel(key: "3-1", color: UIColor(red: 234/255, green: 151/255, blue: 172/255, alpha: 1)),
            ReorderModel(key: "3-2", color: UIColor(red: 198/255, green: 201/255, blue: 208/255, alpha: 1)),
            ReorderModel(key: "3-3", color: UIColor(red: 194/255, green: 77/255, blue: 109/255, alpha: 1)),
            ReorderModel(key: "3-4", color: UIColor(red: 228/255, green: 180/255, blue: 189/255, alpha: 1)),
            ReorderModel(key: "3-5", color: UIColor(red: 196/255, green: 117/255, blue: 132/255, alpha: 1)),
            ReorderModel(key: "3-6", color: UIColor(red: 214/255, green: 228/255, blue: 196/255, alpha: 1)),
        ]
        ]
    }
}
