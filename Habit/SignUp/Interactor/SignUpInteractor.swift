//
//  SignUpInteractor.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-17.
//

import Foundation
import Combine

class SignUpInteractor {
    
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SignUpInteractor {
    
    func postUser(signUpRequest request: SignUpRequest) -> Future<Bool, AppError> {
        
        //remote.login(request: request, completion: completion)
        return remoteSignUp.postUser(request: request)
        
    }
    
    func login(signInRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        
        //remote.login(request: request, completion: completion)
        return remoteSignIn.login(request: request)
        
    }
    
    func insertAuth (userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
}
