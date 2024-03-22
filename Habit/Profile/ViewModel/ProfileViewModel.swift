//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-21.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthDayValidation()
    
}


class FullNameValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "Teste" {
        didSet {
            failure = value.count < 3
        } //didSet
    } //value
    
}


class PhoneValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "11912341234" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        } //didSet
    } //value
    
}

class BirthDayValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "20/02/1990" {
        didSet {
            failure = value.count != 10
        } //didSet
    } //value
    
}
