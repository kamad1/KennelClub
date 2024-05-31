//
//  Person.swift
//  RealmTestProject
//
//  Created by Влад Мади on 27.05.2024.
//

import Foundation
import RealmSwift

class Person: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var address: String?
    @Persisted var age: Int = 0
    @Persisted var height: Double?
    @Persisted var dogs: List<Dog>
    
    convenience init(name: String, address: String, age: Int, height: Double?) {
        self.init()
        self.name = name
        self.age = age
        self.address = !address.isEmpty ? address : nil
        self.height = height
    }
    
}
