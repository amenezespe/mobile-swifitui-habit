//
//  SignInInteractor.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-13.
//

import Foundation
import Combine

class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
  
    
    
}

extension SignInInteractor {
    
    func login (loginRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        
        //remote.login(request: request, completion: completion)
        return remote.login(request: request)
        
    }
    
    func insertAuth (userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
    
//    func fetchAuth() -> Future<UserAuth?, Never> {
//       return local.getUserAuth()
//    }
    
}
