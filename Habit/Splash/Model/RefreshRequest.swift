//
//  RefreshRequest.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-18.
//

import Foundation
struct RefreshRequest: Encodable {
    
    let token: String
    
    enum CodingKeys: String, CodingKey {
        //se o nome da variavel for igual ao nome do json nao precisa do : se for diferente coloca nome da var = nome da chave
        case token = "refresh_token"
    }
    
}
