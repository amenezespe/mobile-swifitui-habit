//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-03.
//

import SwiftUI

enum SignUpViewRouter {
    
    static func makeHomeView () -> some View {
        
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
