//
//  SplashInteractor.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-17.
//

import Foundation
import Combine

class SplashInteractor {
    
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
}

extension SplashInteractor {
    
    func fetchAuth() -> Future<UserAuth?, Never> {
       return local.getUserAuth()
    }
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return remote.refreshToken(request: request)
    }
    
    func insertAuth (userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
    
    
}
