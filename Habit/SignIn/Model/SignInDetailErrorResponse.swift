//
//  SignInDetailErrorResponse.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-12.
//

import Foundation

struct SignInDetailErrorResponse: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
