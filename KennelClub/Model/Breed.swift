//
//  Breed.swift
//  RealmTestProject
//
//  Created by Влад Мади on 27.05.2024.
//

import Foundation
import RealmSwift

enum Breed: String, PersistableEnum {
    case husky = "Хаски"
    case bulldog = "Бульдог"
    case pitbull = "Питбуль"
    case pudel = "Пудель"
    case scotchTerier = "Скотч-терьер"
    case taksa = "Такса"
}

