//
//  ResultViewController.swift
//  MobileTravelGame
//
//  Created by Anatolii Tomazov on 21/03/2020.
//  Copyright © 2020 Anatolii Tomazov. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var currentResults: [Result]!
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentResults = ResultsSingleton.results
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
        
        let result = currentResults[indexPath.row]
        cell.dateCreatedLabel.text = dateFormatter.string(from: result.dateCreated)
        cell.intervalLabel.text = "Spended time: \(String(format: "%.2f", result.interval))"
        
        switch result.type {
        case "Completed":
            cell.scoreLabel.text = "Score: full"
        case "Uncompleted":
            cell.scoreLabel.text = "Score: \(String(format: "%.2f", result.score))"
        default: break
        }
           
      
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func groupResults(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex != 0 {
            currentResults = ResultsSingleton.results.filter({ $0.type == sender.titleForSegment(at: sender.selectedSegmentIndex)})
            
           
        } else {
            currentResults = ResultsSingleton.results
        }
         tableView.reloadData()
        
    }
    
}
