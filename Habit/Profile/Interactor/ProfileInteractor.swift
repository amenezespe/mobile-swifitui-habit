//
//  ProfileInteractor.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-22.
//

import Foundation
import Combine

class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared
}

extension ProfileInteractor {
    
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return remote.fetchUser()
        
    }
    
    func updatehUser(userId: Int, request: ProfileRequest) -> Future<ProfileResponse, AppError> {
        return remote.updateUser(userId: userId, profileRequest: request)
        
    }
    
}
