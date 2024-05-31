//
//  PersonViewModel.swift
//  RealmTestProject
//
//  Created by Влад Мади on 30.05.2024.
//

import Foundation

class PersonViewModel: ObservableObject {
    @Published var person: Person
    @Published var birthday: Date = .now
    @Published var breed: Breed = .husky
    @Published var dogName: String = ""
    
    init(person: Person) {
        self.person = person
    }
    
    func getData() {
        let id = self.person._id
        guard let person = RealmService.shared.getPersonBy(id) else { return }
        self.person = person
    }
    
    func addDog() {
        guard birthday < .now else { return }
        guard !dogName.isEmpty else { return }
        let newDog = Dog(name: dogName,
                         breed: breed,
                         birthDate: birthday)
        RealmService.shared.addDog(newDog, to: person)
        getData()
    }
}
