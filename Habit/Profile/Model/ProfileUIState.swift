//
//  ProfileUIState.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-22.
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
