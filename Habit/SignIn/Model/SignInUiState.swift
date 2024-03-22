//
//  SignInUiState.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-03.
//

import Foundation

enum SignInUiState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
