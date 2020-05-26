//
//  Result.swift
//  MobileTravelGame
//
//  Created by Anatolii Tomazov on 22/03/2020.
//  Copyright © 2020 Anatolii Tomazov. All rights reserved.
//

import Foundation

struct Result {
    let dateCreated: Date
    let score: Float
    let interval: TimeInterval
    let type: String
    
    init(score: Float, dateCreated: Date, type: String) {
        self.score = score
        self.dateCreated = dateCreated
        self.interval = Date().timeIntervalSince(dateCreated)
        self.type = type
    }
}
