//
//  HabitDetailUiState.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import Foundation

enum HabitDetailUiState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
