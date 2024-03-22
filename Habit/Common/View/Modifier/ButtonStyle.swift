//
//  ButtonStyle.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("labelButtonColor"))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(Color("buttonColor"))
            .cornerRadius(4.0)
    }
}
