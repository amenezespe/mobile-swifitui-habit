//
//  HabitResponse.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-24.
//

import Foundation

struct HabitValuesResponse: Decodable {
    let id: Int
    let value: Int
    let habitId: Int
    let createdDate: String
    
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case value
        case habitId = "habit_id"
        case createdDate = "created_date"
    }
}
