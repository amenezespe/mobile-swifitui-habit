//
//  SplashViewRoute.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-02.
//

import SwiftUI


enum SplashViewRouter {
    
    static func makeSignView () -> some View {
        
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        return SignInView(viewModel: viewModel)
    }
    
    static func makeHomeView () -> some View {
        
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
