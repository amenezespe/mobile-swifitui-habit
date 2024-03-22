//
//  SignUpUIState.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-03.
//

import Foundation

enum SignUpUIState: Comparable {
    case none
    case loading
    case success
    case error(String)
}
