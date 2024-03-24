//
//  HabitDetailViewRouter.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import SwiftUI
import Combine

enum HabitDetailViewRouter {
    
    static func makeHabitDetailView (id: Int, name: String, label: String, habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label, interactor: HabitDetailInteractor())
        viewModel.habitPublisher = habitPublisher
        
        return HabitDetailView(viewModel: viewModel)
    }
    
    static func makeChartView (id: Int) -> some View {
        let viewModel = ChartViewModel(habitId: id, interactor: ChartInteractor())
        
        return ChartView(viewModel: viewModel)
    }


}
