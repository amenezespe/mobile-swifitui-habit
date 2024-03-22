//
//  AppError.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-17.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String? {
        switch self {
        case .response(let message):
            return message
        }
    }
}
