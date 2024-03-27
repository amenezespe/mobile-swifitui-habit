//
//  SignInViewModel.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-02.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {

    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SignInUiState = .none
    @Published var email = ""
    @Published var password = ""
    
    private let interactor: SignInInteractor
    private let homeViewModel: HomeViewModel
    
    init(interactor: SignInInteractor, homeViewModel: HomeViewModel) {
        self.interactor = interactor
        self.homeViewModel = homeViewModel

        cancellable = publisher.sink { value in
            print("Usuario Criado ! GoToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    //quando o objeto morrer
    //descontrustor
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    func login() {
        
        self.uiState = .loading
        cancellableRequest =  interactor.login(loginRequest: SignInRequest(email: email,
                                                     password: password))
        .receive(on: DispatchQueue.main)
        .sink { completion in
            //acontece o error
            switch(completion) {
                case .failure(let appError):
                self.uiState = .error(appError.message ?? "Erro desconnhecido!")
                    break
                case .finished:
                    break
            }
            //
        } receiveValue: { success in
            //acontece o SUCESSO
            //convertendo
            let auth = UserAuth(idToken: success.accessToken, 
                                refreshToken: success.refreshToken,
                                expires: Date().timeIntervalSince1970 + Double(success.expires), // Date().timeIntervalSince1970 funcao para data atual
                                tokenType: success.tokenType)
            
            self.interactor.insertAuth(userAuth: auth)
            
            self.uiState = .goToHomeScreen
        }

        
//        interactor.login(loginRequest: SignInRequest(email: email,
//                                                password: password)) { (successResponse, errorResponse) in
//            
//            if let error = errorResponse {
//                //delega essa execuçao para ser realizda na tread pricipal, a que controla a UI
//                DispatchQueue.main.async {
//                    self.uiState = .error(error.detail.message)
//                }
//                
//            } //if error
//            
//            if let success = successResponse {
//                
//                //delega essa execuçao para ser realizda na tread pricipal, a que controla a UI
//                DispatchQueue.main.async {
//                    print(success)
//                    self.uiState = .goToHomeScreen
//                }
//                
//            } //if success
//        }//interactor
    }
    
}

extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView(homeViewModel: homeViewModel)
    }
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
