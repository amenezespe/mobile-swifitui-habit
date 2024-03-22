//
//  ProfileResponse.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-22.
//

import Foundation



struct ProfileResponse: Encodable {
    
    let id: Int
    let fullname: String
    let email: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        //se o nome da variavel for igual ao nome do json nao precisa do : se for diferente coloca nome da var = nome da chave
        case fullname = "name"
        case email
        case document
        case phone
        case birthday
        case gender
    }
    
}
