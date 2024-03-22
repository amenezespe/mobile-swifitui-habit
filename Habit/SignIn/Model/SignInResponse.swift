//
//  SignInResponse.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-11.
//

import Foundation


struct SignInResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let expires: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        //se o nome da variavel for igual ao nome do json nao precisa do : se for diferente coloca nome da var = nome da chave
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
     
    }
}
