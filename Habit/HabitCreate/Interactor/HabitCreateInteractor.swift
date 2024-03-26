//
//  HabitCreateInteractor.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-26.
//
import SwiftUI
import Combine

class HabitCreateInteractor {
    
    private let remote: HabitCreateRemoteDataSource = .shared
}

extension HabitCreateInteractor {
    
    func save(habitCreateRequest request: HabitCreateRequest) -> Future<Void, AppError> {
        return remote.save(request: request)
        
    }
    
}
