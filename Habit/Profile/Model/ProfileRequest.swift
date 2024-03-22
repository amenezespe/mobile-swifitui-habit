//
//  ProfileRequest.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-22.
//

import Foundation

struct ProfileRequest: Encodable {
    
    let fullname: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullname = "name"
        case phone
        case birthday
        case gender
    }
    
}
