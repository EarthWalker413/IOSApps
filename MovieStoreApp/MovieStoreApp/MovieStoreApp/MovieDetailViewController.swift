//
//  MovieDetailViewController.swift
//  MovieStoreApp
//
//  Created by Anatolii Tomazov on 25/05/2020.
//  Copyright © 2020 Anatolii Tomazov. All rights reserved.
//

import UIKit
protocol DetailViewControllerDelegate: class {
    func detailViewController(_ controller: MovieDetailViewController, didFinishAdding newMovie: Movie)
    func detailViewController(_ controller: MovieDetailViewController, didFinishEditing updatedMovie: Movie)
}

class MovieDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var movieToEdit: Movie? = nil
    weak var movieDelegate: DetailViewControllerDelegate? = nil
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        if let movie = movieToEdit {
            title = "Edit Movie"
            titleField.isUserInteractionEnabled = false
            titleField.text = movie.title
            priceField.text = String(movie.price)
            dateLabel.text = dateFormatter.string(from: movie.dateCreated)
            if let imageData = movie.image {
                imageView.image = UIImage(data: imageData)
            }
        } else {
            dateLabel.text = dateFormatter.string(from: Date())
            
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if let movie = movieToEdit {
           
            
            guard let priceText = priceField.text, let price = Double(priceText) else {
                presentFailureController(message: "Price field must be filled")
                return
            }
            
            if let image = imageView.image, let imageData = image.jpegData(compressionQuality: 0.2) {
                let updatedMovie = Movie(title: movie.title, price: price, image: imageData)
                movieDelegate?.detailViewController(self, didFinishEditing: updatedMovie)
            } else {
                let updatedMovie = Movie(title: movie.title, price: price)
                movieDelegate?.detailViewController(self, didFinishEditing: updatedMovie)
            }
            
        } else {
            guard let title = titleField.text, !title.trimmingCharacters(in: .whitespaces).isEmpty  else {
                presentFailureController(message: "Title field must be filled")
                return
            }
            
            guard let priceText = priceField.text, let price = Double(priceText) else {
                presentFailureController(message: "Price field must be filled")
                return
            }
            
            if let image = imageView.image, let imageData = image.jpegData(compressionQuality: 0.2) {
                let movie = Movie(title: title, price: price, image: imageData)
                 movieDelegate?.detailViewController(self, didFinishAdding: movie)
            } else {
                let movie = Movie(title: title, price: price)
                movieDelegate?.detailViewController(self, didFinishAdding: movie)
            }
           
        }
    }
    
    func presentFailureController(message: String) {
        let controller = UIAlertController(title: "FAILURE", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(controller, animated: true)
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func exit(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
}
