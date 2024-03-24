//
//  ChartInteractor.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-24.
//

import Foundation
import Combine

class ChartInteractor {
    
    private let remote: ChartRemoteDataSource = .shared
}

extension ChartInteractor {
    
    func fetchHabitValues (habitId: Int) -> Future<[HabitValuesResponse], AppError> {
        return remote.fetchHabitValues(habitId: habitId)
        
    }
}
