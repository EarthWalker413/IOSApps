//
//  Movie.swift
//  MovieStoreApp
//
//  Created by Anatolii Tomazov on 25/05/2020.
//  Copyright © 2020 Anatolii Tomazov. All rights reserved.
//

import Foundation
import RealmSwift

class Movie: Object {
    @objc dynamic var title: String
    @objc dynamic var price: Double = 0
    @objc dynamic var dateCreated: Date
    @objc dynamic var image: Data? = nil
    
    
    init(title: String, price: Double) {
        self.title = title
        self.price = price
        self.dateCreated = Date()
    }
    
    init(title: String, price: Double, image: Data) {
        self.title = title
        self.price = price
        self.dateCreated = Date()
        self.image = image
    }
    
    override required init() {
        self.title = ""
        self.price = 0
        self.dateCreated = Date()
    }
    
    override static func primaryKey() -> String? {
        return "title"
    }
}
