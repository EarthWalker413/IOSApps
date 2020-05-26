//
//  ViewController.swift
//  SpringAnimation
//
//  Created by Anatolii Tomazov on 23/11/2019.
//  Copyright © 2019 Anatolii Tomazov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var labelPositionCounter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBOutlet weak var label: UILabel!
    
    @IBAction func startAnimation(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            switch self.labelPositionCounter {
            case 0:
                self.label.center.x = self.view.bounds.width - 100
                self.labelPositionCounter += 1
            case 1:
                self.label.center.x = self.view.bounds.width - 100
                self.label.center.y = self.view.bounds.height - 100
                self.labelPositionCounter += 1
            case 2:
                self.label.center.x = 100
                self.label.center.y = self.view.bounds.height - 100
                self.labelPositionCounter += 1
            case 3:
                self.label.center.y = 100
                self.labelPositionCounter += 1
            default:
                let alert = UIAlertController(title: "Message", message: "You have complited the path", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                self.labelPositionCounter = 0

            }
           
        }, completion: nil)
    }
    
}

