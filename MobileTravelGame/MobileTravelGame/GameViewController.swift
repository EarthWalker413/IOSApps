//
//  ViewController.swift
//  MobileTravelGame
//
//  Created by Anatolii Tomazov on 21/03/2020.
//  Copyright © 2020 Anatolii Tomazov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var progress: Float!
    
    var createdDate: Date!
    
    var buttons: [CellButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress = 0
        createdDate = Date()
        buttons = [CellButton]()
        setButtons()
    }
  
    
    func setButtons() {
        for i in 0 ... 70 {
            buttons.append(CellButton())
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        return cell
    }
    
    
    
    @IBAction func showQuestion(_ sender: CellButton) {
        
        let alertController = UIAlertController(title: sender.quiz.question, message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned alertController] _ in
            if let answer = Int(alertController.textFields![0].text!) {
                if answer == sender.quiz.getAnswer() {
                    self.updateButtonState(button: sender, answer: answer)
                    let updateValue = Float(answer)/700
                    self.updateProgress(value: updateValue)
                    self.checkProgress()
                }
                
            }
            
        }
        
        alertController.addAction(submitAction)
        
        present(alertController, animated: true)
    }
    
    func updateButtonState(button: CellButton, answer: Int) {
        button.setTitle(String(answer) as String, for: .normal)
        button.backgroundColor = .red
        button.setImage(.none, for: .normal)
        button.isUserInteractionEnabled = false
    }
    
    func updateProgress(value: Float) {
        progress += value
        progressView.setProgress(progress, animated: false)
    }
    
    func checkProgress() {
        if progress >= 1 {
            finishGame(completed: true)
        }
    }
    
    func finishGame(completed: Bool) {
        dismiss(animated: true, completion: {
            let curdate = Date().timeIntervalSince(self.createdDate)
            print(curdate)
            if completed {
                let result = Result(score: self.progress, dateCreated: self.createdDate, type: "Completed")
                ResultsSingleton.results.append(result)
                print(ResultsSingleton.results.count)
            } else {
                let result = Result(score: self.progress, dateCreated: self.createdDate, type: "Uncompleted")
                ResultsSingleton.results.append(result)
                print(ResultsSingleton.results.count)
            }
        })
    }
    
    
    @IBAction func quitGame(_ sender: UIBarButtonItem) {
        finishGame(completed: false)
    }
    
}

