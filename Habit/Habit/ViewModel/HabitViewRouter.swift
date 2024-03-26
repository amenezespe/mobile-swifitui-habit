//
//  HabitViewRouter.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-25.
//

import SwiftUI
import Combine

enum HabitViewRouter {
    
    static func habitCreateView (habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        
        let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
        viewModel.habitPublisher = habitPublisher
        
        return HabitCreateView(viewModel: viewModel)
    }

}
