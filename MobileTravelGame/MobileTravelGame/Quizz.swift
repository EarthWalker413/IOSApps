//
//  quiz.swift
//  MobileTravelGame
//
//  Created by Anatolii Tomazov on 21/03/2020.
//  Copyright © 2020 Anatolii Tomazov. All rights reserved.
//

import Foundation

class Quiz {
    
    let question: String
    let number1: Int
    let number2: Int
    
    init() {
        self.number1 = Int.random(in: 0 ... 10)
        self.number2 = Int.random(in: 0 ... 10)
        self.question = "\(number1) * \(number2) equals to"
    }
    
    func getAnswer() -> Int {
        let answer = number1 * number2
        return answer
    }
    
    
}
