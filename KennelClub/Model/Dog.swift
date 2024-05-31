//
//  Dog.swift
//  RealmTestProject
//
//  Created by Влад Мади on 27.05.2024.
//

import Foundation
import RealmSwift

class Dog: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var breed: Breed = .bulldog
    @Persisted var birthDate = Date()
    
    
    convenience init(name: String, breed: Breed, birthDate: Date) {
        self.init()
        self.name = name
        self.breed = breed
        self.birthDate = birthDate
    }
}

