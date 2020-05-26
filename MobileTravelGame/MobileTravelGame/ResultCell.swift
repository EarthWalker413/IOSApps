//
//  ResultCell.swift
//  MobileTravelGame
//
//  Created by Anatolii Tomazov on 22/03/2020.
//  Copyright © 2020 Anatolii Tomazov. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    
    
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        dateCreatedLabel.adjustsFontSizeToFitWidth = true
        intervalLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.adjustsFontSizeToFitWidth = true
    }
    
}
