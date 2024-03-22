//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import Foundation
import Combine

class HabitDetailInteractor {
    
    private let remote: HabitDetailRemoteDataSource = .shared
    
}

extension HabitDetailInteractor {
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        return remote.save(habitId: habitId, request: request)
    }

    
}
