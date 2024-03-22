//
//  ErrorResponse.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-11.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
