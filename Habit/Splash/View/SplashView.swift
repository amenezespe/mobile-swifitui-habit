//
//  SplashView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-02.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        
        Group {
            
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                viewModel.signInView()
            case .goToHomeInScreen:
                viewModel.homeView()
            case .error(let message):
                loadingView(error: message)
            }
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

extension SplashView {
    func loadingView(error : String? = nil) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                //.background(Color.white)
                .ignoresSafeArea()
            
            if let error = error  {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Clipipe"), message: Text(error), dismissButton: .default(Text("OK")) {
                            //faz algo quando some o alerta
                        })
                    }
            }
        }
    }
}
let viewModel = SplashViewModel(interactor: SplashInteractor())

#Preview {
    SplashView(viewModel: viewModel)
}

