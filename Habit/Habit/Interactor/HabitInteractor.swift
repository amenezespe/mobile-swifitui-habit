//
//  HabitInteractor.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import Foundation
import Combine

class HabitInteractor {
    
    private let remote: HabitRemoteDataSource = .shared
}

extension HabitInteractor {
    
    func fechHabits () -> Future<[HabitResponse], AppError> {
       return remote.fechHabits()
    }
    

    
}
