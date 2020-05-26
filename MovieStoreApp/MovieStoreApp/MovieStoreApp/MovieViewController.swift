//
//  ViewController.swift
//  MovieStoreApp
//
//  Created by Anatolii Tomazov on 25/05/2020.
//  Copyright © 2020 Anatolii Tomazov. All rights reserved.
//

import UIKit
import RealmSwift

class MovieViewController: UITableViewController, DetailViewControllerDelegate {
    func detailViewController(_ controller: MovieDetailViewController, didFinishAdding newMovie: Movie) {
        try! realm.write {
            realm.add(newMovie)
        }
        dismiss(animated: false, completion: nil)
        tableView.reloadData()
    }
    
    func detailViewController(_ controller: MovieDetailViewController, didFinishEditing updatedMovie: Movie) {
        let movie = Movie(title: updatedMovie.title, price: updatedMovie.price)
        
        movie.title = updatedMovie.title
        movie.price = updatedMovie.price
       

        if let imageData = updatedMovie.image {
            movie.image = imageData
        }

        try! realm.write {
            realm.add(movie, update: .all)
        }
        
       
        dismiss(animated: false, completion: nil)
        tableView.reloadData()
    }
    

    var movies: Results<Movie>!
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        movies = realm.objects(Movie.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        let movie = movies[indexPath.row]

        let titleLabel = cell.viewWithTag(1001) as! UILabel
        titleLabel.text = movie.title

        let priceLabel = cell.viewWithTag(1002) as! UILabel
        priceLabel.text = String(movie.price)

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = movies[indexPath.row]
            let controller = UIAlertController(title: nil, message: "Are yout sure you want to remove \(movie.title)", preferredStyle: .actionSheet)
            controller.addAction(UIAlertAction(title: "REMOVE", style: .default, handler: { (action) -> Void in
                try! self.realm.write {
                    self.realm.delete(movie)
                }
                tableView.reloadData()
            }))
            controller.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
            present(controller, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addMovie":
            let navigationController = segue.destination as! UINavigationController
            let detailController = navigationController.topViewController as! MovieDetailViewController
            detailController.movieDelegate = self
        case "editMovie":
            let navigationController = segue.destination as! UINavigationController
            let detailController = navigationController.topViewController as! MovieDetailViewController
            if let row = tableView.indexPathForSelectedRow?.row {
                detailController.movieDelegate = self
                let movieCopy = movies[row]
                detailController.movieToEdit = movieCopy
            }

        default:
            return
        }
    }

}

