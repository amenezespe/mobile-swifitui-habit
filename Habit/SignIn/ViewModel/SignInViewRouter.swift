//
//  SignInViewRouter.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-03.
//

import SwiftUI
import Combine

enum SignInViewRouter {
    
    static func makeHomeView () -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
    static func makeHomeView (homeViewModel: HomeViewModel) -> some View {
        return HomeView(viewModel: homeViewModel)
    }
    
    static func makeSignUpView (publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel(interactor: SignUpInteractor())
        viewModel.publisher = publisher
        
        return SignUpView(viewModel: viewModel)
    }
}


