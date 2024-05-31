//
//  PersonView.swift
//  RealmTestProject
//
//  Created by Влад Мади on 30.05.2024.
//

import SwiftUI

struct PersonView: View {
    @StateObject var viewModel: PersonViewModel
    @State private var showNewDogSheet = false

    
    var body: some View {
        List(viewModel.person.dogs, id: \._id) { dog in
            Text(dog.name)
        }
            .navigationTitle(viewModel.person.name)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    showNewDogSheet = true
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
                if showNewDogSheet {
                    NewDogSheet()
                }
            }
    }
    
    @ViewBuilder
    func NewDogSheet() -> some View {
        VStack {
            Text("Добавить собаку пользователю \(viewModel.person.name)").font(.title3.bold())
            TextField("Имя", text: $viewModel.dogName)
                .modifier(TextFieldModifier())
            DatePicker("Дата рождения", selection: $viewModel.birthday, displayedComponents: .date)
            Picker("", selection: $viewModel.breed) {
                ForEach(Breed.allCases, id: \.self) { breed in
                    Text(breed.rawValue)
                }
            }
            Button {
                showNewDogSheet = false
                viewModel.addDog()
                viewModel.dogName.removeAll()
                showNewDogSheet = false
            } label: {
                Text("Сохранить")
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }.frame(width: 250)
            .padding()
            .background(.white)
            .clipShape(.rect(cornerRadius: 20))
        
        
        
    }
}

#Preview {
    PersonView(viewModel: .init(person: .init()))
}
