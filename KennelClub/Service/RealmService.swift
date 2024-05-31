//
//  RealmService.swift
//  RealmTestProject
//
//  Created by Влад Мади on 27.05.2024.
//

import Foundation
import RealmSwift

class RealmService {
    static let shared = RealmService(); private init() { }
    private let realm = try! Realm()
    
    func getUrl() -> String {
        guard let url = realm.configuration.fileURL else {
            return "REALM не найден"
        }
        
        return url.absoluteString
    }
    
    //MARK: - CRUD
    //MARK: Create
    func createPerson(_ object: Object) {
        try! realm.write { realm.add(object) }
    }
    
    //MARK: Retrieve (Read)
    func getAllPeople() -> [Person] {
        let peopleList = realm.objects(Person.self)
        return Array(peopleList)
    }
    
    func getPersonBy(_ id: ObjectId) -> Person? {
        return realm.object(ofType: Person.self,
                            forPrimaryKey: id)
    }
    
    func getAllDogs() -> [Dog] {
        let dogList = realm.objects(Dog.self)
        return Array(dogList)
    }
    
    func getDogsOfPerson(withID id: ObjectId) -> [Dog] {
        guard let person = getPersonBy(id) else { return [] }
        let dogs = person.dogs
        return Array(dogs)
    }
    
    func getChildren() -> [Person] {
        let childrenQuery = realm.objects(Person.self).where { person in
            person.age < 18
        }
        
        return Array(childrenQuery)
    }
    
    //MARK: Update
    func updatePerson(byID id: ObjectId,
                      newName: String? = nil,
                      newAge: Int? = nil,
                      newHeight: Double? = nil,
                      newAddress: String? = nil) {
        guard let person = getPersonBy(id) else { return }
        
        try! realm.write {
            if let newName { person.name = newName }
            if let newAge { person.age = newAge }
            if let newHeight { person.height = newHeight }
            if let newAddress { person.address = newAddress }
        }
    }
    
    func addDog(_ dog: Dog, to person: Person) {
        guard let person = getPersonBy(person._id) else { return }
        
        try! realm.write {
            person.dogs.append(dog)
        }
    }
    
    //MARK: Delete
    func deletePerson(_ person: Person) {
            try! realm.write {
                realm.delete(person.dogs)
                realm.delete(person)
            }
    }
    
    func deleteDog(_ dog: Dog) {
        try! realm.write {
            realm.delete(dog)
        }
    }
    
    func deleteAllDogs() {
        try! realm.write {
            let allDogs = realm.objects(Dog.self)
            realm.delete(allDogs)
        }
    }
    
    func clearRealm() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}


/*
 //Bool
 //Int'ы
 //Double, Float
 //String
 //Data
 //Date
 //UUID
 //ObjectId
 //List
 //MutableSet
 //Enum -> String
 //Object
 */

