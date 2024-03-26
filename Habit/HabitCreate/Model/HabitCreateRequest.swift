//
//  HabitCreateRequest.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-26.
//

import Foundation

//Encodable e decodable somente para chamadas json
struct HabitCreateRequest {
    
    let imageData: Data?
    let name: String
    let label: String
}
