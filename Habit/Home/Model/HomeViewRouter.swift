//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-18.
//

import SwiftUI

enum HomeViewRouter {
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
    
    static func makeProfileView(viewModel: ProfileViewModel) -> some View {
        return ProfileView(viewModel: viewModel)
    }
}
