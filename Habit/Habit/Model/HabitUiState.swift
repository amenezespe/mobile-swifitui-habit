//
//  HabitUiState.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-18.
//

import Foundation

enum HabitUiState: Equatable {

    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
