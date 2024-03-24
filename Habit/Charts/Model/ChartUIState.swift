//
//  ChartUIState.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-24.
//

import Foundation

enum ChartUIState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
    
}
