//
//  SignUpView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-03.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
 
    
    var body: some View {
        
        ZStack {
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .center, spacing: 8) {
                    
                    VStack (alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        
                        emailField
                        
                        passwordField
                        
                        documentField
                        
                        phoneField
                        
                        birthDayField
                        
                        genderField
                        
                        saveButton
                        
                        
                    } //Vstack 2
                    
                    Spacer()
                    
                }.padding(.horizontal, 8) //Vstack 1
            }.padding() //scrollview
            
            if case SignUpUIState.error(let error) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Clipipe"), message: Text(error), dismissButton: .default(Text("OK")) {
                            //faz algo quando some o alerta
                        })
                    }//alert
            }// if case error
        } // ZStack
       
    } //struc
}


extension SignUpView {
    var emailField : some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "Email",
                     keyboard: UIKeyboardType.emailAddress,
                     error: "Email inválido",
                     failure: !viewModel.email.isEmail())
    
    }
}

extension SignUpView {
    var passwordField : some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     keyboard: .emailAddress,
                     error: "Senha inválida",
                     failure: viewModel.password.isEmpty,
                     isSecure: true)
    }
}

extension SignUpView {
    var fullNameField : some View {
        EditTextView(text: $viewModel.fullname,
                     placeholder: "Nome Completo",
                     keyboard: .alphabet,
                     error: "Nome inválido",
                     failure: viewModel.fullname.count < 3)
    
    }
}

extension SignUpView {
    var documentField : some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "Digite CPF",
                     keyboard: .numberPad,
                     error: "Documento inválido",
                     failure: viewModel.document.count != 11)
        
        //TODO: MAsk
        //TODO isDisabled
    }
}

extension SignUpView {
    var phoneField : some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Digite seu telefone",
                     keyboard: .namePhonePad,
                     error: "Telefone inválido",
                     failure: viewModel.phone.count < 10 || viewModel.phone.count >= 12)
    }
}

extension SignUpView {
    var birthDayField : some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Entre com usa data de Nascimento",
                     keyboard: .default,
                     error: "Data de Nascimento inválida",
                     failure: viewModel.birthday.count != 10)
    }
}

extension SignUpView {
    var genderField : some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) {
                value in
                Text(value.rawValue)
                    .tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)
            .padding(.bottom, 32)
    }
}

extension SignUpView {
    var saveButton : some View {
       
        LoadingButtonView(action: {
            viewModel.signUp()
        }, text: "Realize seu Cadastro", showProgressBar: self.viewModel.uiState == SignUpUIState.loading,
                          disabled: !viewModel.email.isEmail() ||
                          viewModel.password.isEmpty ||
                          viewModel.fullname.count < 3 ||
                          viewModel.document.count != 11 ||
                          viewModel.phone.count < 10 || viewModel.phone.count >= 12 ||
                          viewModel.birthday.count != 10  )
    }
}


let viewModelSignUp = SignUpViewModel(interactor: SignUpInteractor())
#Preview {
    SignUpView(viewModel: viewModelSignUp)
}
