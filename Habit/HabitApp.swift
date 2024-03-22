//
//  HabitApp.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-02.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
