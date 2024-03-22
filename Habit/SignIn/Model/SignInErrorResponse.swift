//
//  SignInErrorResponse.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-12.
//

import Foundation

struct SignInErrorResponse: Decodable {
    let detail: SignInDetailErrorResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
