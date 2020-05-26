//
//  CellButton.swift
//  MobileTravelGame
//
//  Created by Anatolii Tomazov on 21/03/2020.
//  Copyright © 2020 Anatolii Tomazov. All rights reserved.
//

import UIKit

class CellButton: UIButton {
    
    var quiz: Quiz
    
    override init(frame: CGRect) {
        self.quiz = Quiz()
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        self.quiz = Quiz()
        super.init(coder: coder)
    }
    
}
