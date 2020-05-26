//
//  ViewController.swift
//  Project_1
//
//  Created by Anatolii Tomazov on 05/12/2019.
//  Copyright © 2019 Anatolii Tomazov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var startGameButton: UIButton!


    let slider = UISlider()
    var currentScore = 5



    override func viewDidLoad()
    {
        super.viewDidLoad()
        addSlider()
        restrictImageInteraption()
    }


    func addSlider(){
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        slider.frame = CGRect(x: 0, y: 0, width: sliderView.frame.size.width, height: sliderView.frame.size.height-100)
        slider.center.y = sliderView.center.y
        slider.center.x = sliderView.center.x

        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .white

        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.setValue(100, animated: false)
        sliderView.addSubview(slider)
    }

    @IBAction func completeMainLogic(_ sender: UIButton) {
        scoreLabel.text = "Score: \(currentScore)"
        restrictStartGameButtonInteraption()
        hideSlider()
        setImages()
        showImages()
        
        //hides images in definite period of time after they appeare
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(getTime())) {
            self.hideImages()
            self.allowImageInteraption()
        }
    }


    func hideSlider() {
        sliderView.isHidden = true
    }

    func restrictStartGameButtonInteraption() {
        startGameButton.isUserInteractionEnabled = false
    }
        
    func setImages() {
        var imageArray = [UIImage(systemName: "folder.fill"), UIImage(systemName: "arrowshape.turn.up.right.fill"), UIImage(systemName: "cloud.fill"), UIImage(systemName: "star.fill"), UIImage(systemName: "bolt.horizontal.fill"), UIImage(systemName: "airplane"), UIImage(systemName: "house.fill"), UIImage(systemName: "hand.thumbsup.fill")].shuffled()
                     
        let randomImage = imageArray.randomElement()!!
        centerButton.setImage(randomImage, for: .normal)
        centerButton.imageView?.alpha = 0
                     
        for button in buttonCollection {
            button.setImage(imageArray.removeFirst(), for: .normal)
            button.imageView?.alpha = 0
            button.backgroundColor = .none
        }
    }

    func showImages() {
        for button in buttonCollection {
            button.backgroundColor = .none
        }
        
       UIView.animate(withDuration: 0.5, animations: {
        for button in self.buttonCollection {
            button.imageView?.alpha = 1
        }
        self.centerButton.imageView?.alpha = 1
       })
    }

    func restrictImageInteraption() {
        for button in buttonCollection {
            button.isUserInteractionEnabled = false
        }
    }


    func allowImageInteraption() {
        for button in buttonCollection {
            button.isUserInteractionEnabled = true
        }
    }


    func hideImages() {
        for button in buttonCollection {
            button.imageView?.alpha = 0
        }
       UIView.animate(withDuration: 0.5, animations: {
            for button in self.buttonCollection {
                button.backgroundColor = .systemIndigo
            }
        })
       
    }

    func getTime() -> Int {
        let time: Int
        switch slider.value {
        case 0..<25:
            time = 2000
        case 25..<50:
            time = 1500
        case 50..<75:
            time = 1000
        default:
            time = 750
        }
        return time
    }

    @IBAction func checkScore(_ sender: UIButton) {
        showImages()
        
        if centerButton.currentImage == sender.currentImage {
            currentScore += 1
        } else {
            currentScore -= 1
        }

        if currentScore <= 0 {
            finishGame("You lose")
        } else  if currentScore >= 10 {
            finishGame("You win")
        } else {
            scoreLabel.text = "Score: \(currentScore)"
        }
        
        startGameButton.isUserInteractionEnabled = true
        restrictImageInteraption()
    }
        
    func finishGame(_ message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
        currentScore = 5
        scoreLabel.text = "Score: \(currentScore)"
        sliderView.isHidden = false
    }
    
    @IBAction func closeApp(_ sender: UIButton) {
        exit(0)
    }
}
