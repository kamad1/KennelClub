//
//  PeopleView.swift
//  RealmTestProject
//
//  Created by Влад Мади on 27.05.2024.
//

import SwiftUI

struct PeopleView: View {
    @StateObject var viewModel = PeopleViewModel()
    @State private var newPersonName: String = ""
    @State private var newPersonHeight: Double?
    @State private var newPersonAddress: String = ""
    @State private var newPersonAge: Int?
    @State private var showNewPersonSheet = false
    @State private var isNewUser = true
    @State private var personForUpdate: Person?
    
    var body: some View {
        List(viewModel.people, id: \._id) { person in
            NavigationLink(person.name) {
                PersonView(viewModel: .init(person: person))
            }
                .listRowSeparator(.hidden)
                .swipeActions {
                    Button {
                        viewModel.deletePerson(person)
                    } label: {
                        Image(systemName: "trash")
                            .tint(.red)
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button {
                        self.newPersonName = person.name
                        self.newPersonAge = person.age
                        self.newPersonAddress = person.address ?? ""
                        self.newPersonHeight = person.height ?? 0
                        isNewUser = false
                        personForUpdate = person
                        showNewPersonSheet = true
                    } label: {
                        Image(systemName: "pencil.and.outline")
                            .tint(.green)
                    }
                }
        }
        .listStyle(.plain)
        .overlay(alignment: .bottomTrailing) {
            Button {
                isNewUser = true
                showNewPersonSheet = true
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .padding()
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(.circle)
                    .padding(8)
            }
        }
        .overlay {
            if showNewPersonSheet {
                NewPersonSheet()
            }
        }
    }
    
    @ViewBuilder
    func NewPersonSheet() -> some View {
        
        VStack {
            Text(isNewUser ? "Новый человечек" : "Изменить пользователя").font(.title3.bold())
            TextField("Имя", text: $newPersonName)
                .modifier(TextFieldModifier())
            TextField("Адрес", text: $newPersonAddress)
                .modifier(TextFieldModifier())
            TextField("Возраст", value: $newPersonAge, format: .number)
                .modifier(TextFieldModifier())
            TextField("Рост", value: $newPersonHeight, format: .number)
                .modifier(TextFieldModifier())
            Button {
                showNewPersonSheet = false
                
                if isNewUser {
                    viewModel.savePerson(name: newPersonName,
                                         age: newPersonAge,
                                         height: newPersonHeight,
                                         address: newPersonAddress)
                } else {
                    guard let personForUpdate else { return }
                    viewModel.updatePerson(personForUpdate,
                                           name: newPersonName,
                                           age: newPersonAge,
                                           height: newPersonHeight,
                                           address: newPersonAddress)
                }
                newPersonAge = nil
                newPersonAddress = ""
                newPersonName = ""
                newPersonHeight = nil
            } label: {
                Text("Сохранить")
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }.frame(width: 250)
    }
}

#Preview {
    PeopleView()
}




















