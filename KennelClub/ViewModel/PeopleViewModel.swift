//
//  PeopleViewModel.swift
//  RealmTestProject
//
//  Created by Влад Мади on 27.05.2024.
//

import Foundation

class PeopleViewModel: ObservableObject {
    @Published var people = [Person]()
    
    init() {
        getData()
    }
    
    func getData() {
        let people = RealmService.shared.getAllPeople()
        self.people = people
    }
    
    func savePerson(name: String, age: Int?, height: Double?, address: String) {
        guard let age else { return }
        guard !name.isEmpty else { return }
        let person = Person(name: name, address: address, age: age, height: height)
        RealmService.shared.createPerson(person)
        getData()
    }
    
    func deletePerson(_ person: Person) {
        DispatchQueue.main.async {
            RealmService.shared.deletePerson(person)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
                self.people = RealmService.shared.getAllPeople()
            }
        }
    }
    
    func updatePerson(_ person: Person, name: String, age: Int?, height: Double?, address: String) {
        RealmService.shared.updatePerson(byID: person._id,
                                         newName: name,
                                         newAge: age,
                                         newHeight: height,
                                         newAddress: address)
        getData()
    }
}
