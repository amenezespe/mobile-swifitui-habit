//
//  UserAuth.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-17.
//

import Foundation

struct UserAuth: Codable {
    var idToken: String
    var refreshToken : String
    var expires: Double = 0
    var tokenType: String
    
    enum CodingKeys: String, CodingKey {
        //se o nome da variavel for igual ao nome do json nao precisa do : se for diferente coloca nome da var = nome da chave
        case idToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
    }
}
