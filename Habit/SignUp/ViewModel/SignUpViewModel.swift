//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-03.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var uiState: SignUpUIState = .none
    
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    
    @Published var gender = Gender.male
    
    private let interactor: SignUpInteractor
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableSignUp?.cancel()
        cancellableSignIn?.cancel()
        
    }
    
    //!- Nao opcional
    var publisher: PassthroughSubject<Bool, Never>!

    
    func signUp() {
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data Inválida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        let signUpRequest = SignUpRequest(fullname: fullname,
                                          email: email,
                                          password: password,
                                          document: document,
                                          phone: phone,
                                          birthday: birthday,
                                          gender: gender.index)
        
        self.cancellableSignUp = interactor.postUser(signUpRequest: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                //error finished
                switch(completion) {
                    case .failure(let appError):
                        self.uiState = .error(appError.message ?? "Erro desconnhecido!")
                        break
                    case .finished:
                        break
                }
            } receiveValue: { created in
                if (created) {
                    
                    self.cancellableSignIn = self.interactor.login(signInRequest: SignInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            //error finished
                            switch(completion) {
                                case .failure(let appError):
                                self.uiState = .error(appError.message ?? "Erro desconnhecido!")
                                    break
                                case .finished:
                                    break
                            }
                        } receiveValue: { success in
                            print(created)
                            let auth = UserAuth(idToken: success.accessToken,
                                                refreshToken: success.refreshToken,
                                                expires: Date().timeIntervalSince1970 + Double(success.expires), // Date().timeIntervalSince1970 funcao para data atual
                                                tokenType: success.tokenType)
                            
                            self.interactor.insertAuth(userAuth: auth)
                            self.publisher.send(created)
                            self.uiState = .success
                        }
                }
                
            }
    }
    
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
