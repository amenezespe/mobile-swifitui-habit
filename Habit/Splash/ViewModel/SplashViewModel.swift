//
//  SplashViewModel.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-02.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    private let interactor: SplashInteractor
        
    init(interactor: SplashInteractor) {
        self.interactor = interactor;
       
    }
    
    //quando o objeto morrer
    //descontrustor
    deinit {
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }

    func onAppear() {
        cancellableAuth = interactor.fetchAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink {userAuth in
                if userAuth == nil { //se o userAuth = null -> Login
                    print("Sem Token ")
                    self.uiState = .goToSignInScreen
                } else if (Date().timeIntervalSince1970 > userAuth!.expires) {
                    //Senao userAuth != null e expirou -> refresh Token
                    //chama o refreshToken
                    print("Token Expirou!")
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: RefreshRequest(token: userAuth!.refreshToken))
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion) {
                                case.failure(_):
                                    self.uiState = .goToSignInScreen
                                    break
                                default:
                                    break
                            }
                        }, receiveValue: { success in
                            let auth = UserAuth(idToken: success.accessToken,
                                                refreshToken: success.refreshToken,
                                                expires: Date().timeIntervalSince1970 + Double(success.expires), // Date().timeIntervalSince1970 funcao para data atual
                                                tokenType: success.tokenType)
                            
                            self.interactor.insertAuth(userAuth: auth)
                            self.uiState = .goToHomeInScreen
                        })
                            
                }
                else { //senao -> tela de Login
                    print("Token Valido")
                    self.uiState = .goToHomeInScreen
                    print( self.uiState )
                }
            }
    }
    
}

extension SplashViewModel {
    
    func signInView () -> some View {
        
        SplashViewRouter.makeSignView()
    }
    
    func homeView() -> some View {
        SplashViewRouter.makeHomeView()
    }
}
