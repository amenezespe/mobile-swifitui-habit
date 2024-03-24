//
//  HomeViewModel.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-03.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let habitViewModel = HabitViewModel(isChart: false, interactor: HabitInteractor())
    let habitForChartViewModel = HabitViewModel(isChart: true, interactor: HabitInteractor())
    let profileViewModel = ProfileViewModel(interactor: ProfileInteractor())
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitViewModel)
    }
    
    func habitVForChartiew() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitForChartViewModel)
    }
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
}
