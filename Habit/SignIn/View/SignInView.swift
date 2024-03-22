//
//  SignInView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-02.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel : SignInViewModel
    @State var action: Int? = 0
    @State var navigationHidden = true
    
    
    var body: some View {
        
        ZStack {
            
            if case SignInUiState.goToHomeScreen = viewModel.uiState {
                
                viewModel.homeView()
                
            } else {
                
                NavigationView {
                    
                    ScrollView (showsIndicators: false) {
                        
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
                            
                            Spacer(minLength: 48)
                            
                            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8) {
                                
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal,48)
                                
                                Text("Login")
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                emailField
                                
                                passwordField
                                
                                enterButton
                                
                                signUpLink
                                
                                Text("Copyright - P2Cloud 2023")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 13).bold())
                                    .padding(.top, 16)
                            }
                        }
                        
                        if case SignInUiState.error(let error) = viewModel.uiState {
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(title: Text("Clipipe"), message: Text(error), dismissButton: .default(Text("OK")) {
                                        //faz algo quando some o alerta
                                    })
                                }//alert
                        }// if case error
                    } //scrolview
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .navigationBarTitle("Login", displayMode: .inline)
                    .navigationBarHidden(navigationHidden)
                }
                .onAppear{
                    self.navigationHidden = true
                }
                .onDisappear{
                    self.navigationHidden = false
                }
            } //ifelse
        } //zstack
    } //view
}

extension SignInView {
    var emailField : some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "Email",
                     keyboard: UIKeyboardType.emailAddress,
                     error: "Email inválido",
                     failure: !viewModel.email.isEmail())
    }
}



extension SignInView {
    var passwordField : some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     keyboard: .emailAddress,
                     error: "Senha inválida",
                     failure: viewModel.password.isEmpty,
                    isSecure: true)
    }
}


extension SignInView {
    var enterButton : some View {
        LoadingButtonView(action: {
            viewModel.login()
        }, text: "Entrar", showProgressBar: self.viewModel.uiState == SignInUiState.loading,
                          disabled: !viewModel.email.isEmail() || viewModel.password.isEmpty)
    }
}

extension SignInView {
    var signUpLink : some View {
        VStack {
            Text("Ainda não possui uma conta")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack {
                NavigationLink(
                    destination: viewModel.signUpView(),
                    tag: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/,
                    selection: $action,
                    label: {EmptyView()})
                
                Button("Realiza Cadastro") {
                    self.action = 1
                } //Button
            } //ZStack
        }
    }
}


let viewModel1 = SignInViewModel(interactor: SignInInteractor())
#Preview {
    SignInView(viewModel: viewModel1)
}
