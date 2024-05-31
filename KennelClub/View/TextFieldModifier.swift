//
//  TextFieldModifier.swift
//  RealmTestProject
//
//  Created by Влад Мади on 27.05.2024.
//

import Foundation
import SwiftUI

struct TextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(6)
            .background(.white)
            .clipShape(.capsule)
            .padding(0.4)
            .background(.gray)
            .clipShape(.capsule)
    }
    
}
