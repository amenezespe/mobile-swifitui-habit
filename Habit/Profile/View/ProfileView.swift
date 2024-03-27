//
//  ProfileView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-21.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone : Bool {
        viewModel.fullNameValidation.failure
        || viewModel.phoneValidation.failure
        || viewModel.fullNameValidation.failure
    }
    
    
    var body: some View {
       
        VStack {
            if case ProfileUIState.loading = viewModel.uiState {
                ProgressView()
            } else {
                NavigationView {
                    VStack {
                        Form {
                            Section(header: Text("Dados cadastrais")) {
                                HStack {
                                    Text("Nome")
                                    Spacer()
                                    TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                        .keyboardType(.alphabet)
                                        .multilineTextAlignment(.trailing)
                                } //HStack
                                
                                if (viewModel.fullNameValidation.failure) {
                                    Text("Nome deve ter mais de 3 caracteres!")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("Email")
                                    Spacer()
                                    TextField("", text: $viewModel.email)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                } //HStack
                                
                                
                                HStack {
                                    Text("CPF")
                                    Spacer()                            
                                    TextField("", text: $viewModel.document)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                } //HStack
                                
                                HStack {
                                    Text("Número de celular")
                                    Spacer()
                                    ProfileEditTextView(text: $viewModel.phoneValidation.value,
                                                 placeholder: "Digite seu telefone",
                                                 mask: "(##) ####-####",
                                                 keyboard: .namePhonePad)
//                                    TextField("Digite o Celular", text: $viewModel.phoneValidation.value)
//                                        .keyboardType(.numberPad)
//                                        .multilineTextAlignment(.trailing)
                                } //HStack
                                
                                if (viewModel.phoneValidation.failure) {
                                    Text("Número de celular inválido!")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("Data de Nascimento")
                                    Spacer()
                                    ProfileEditTextView(text: $viewModel.birthdayValidation.value,
                                                 placeholder: "Digite a Data de Nascimento",
                                                 mask: "##/##/####",
                                                 keyboard: .numberPad)
                                    
//                                    TextField("Digite a Data de Nascimento", text: $viewModel.birthdayValidation.value)
//                                        .multilineTextAlignment(.trailing)
                                } //HStack
                                
                                
                                if (viewModel.birthdayValidation.failure) {
                                    Text("Data de nascimento inválida!")
                                        .foregroundColor(.red)
                                }
                                
                                NavigationLink(
                                    destination: GenderSelectorView(selectedGender: $viewModel.gender,
                                                                    title: "Escolha o gênero",
                                                                    genders: Gender.allCases),
                                    label: {
                                        HStack {
                                            Text("Gênero")
                                            Spacer()
                                            Text(viewModel.gender?.rawValue ?? "")
                                        }
                                    })
                                
                            } //Section
                        
                        } //Form
                        
                    } //VStack
                    .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.updateUser()
                        
                        
                    }, label: {
                        if case ProfileUIState.updateLoading = viewModel.uiState {
                            ProgressView()
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                       
                    }) //Button
                        .alert(isPresented: .constant(viewModel.uiState == .updateSuccess)){
                            Alert(title: Text("Clipipe"),
                                  message: Text("Dados atualizados com sucesso!"),
                                  dismissButton: .default(Text("OK")) {
                                
                            })
                        }
                        .opacity(disableDone ? 0 : 1)
                    ) //navigationBarItems
                    
                } //NavigationView
            } //else
            
            if case ProfileUIState.updateError(let error) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Clipipe"),
                              message: Text(error),
                              dismissButton: .default(Text("OK")) {
                            viewModel.uiState = .none
                        })
                    }//.alert
            }// if case error
            
            if case ProfileUIState.error(let error) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Clipipe"),
                              message: Text(error),
                              dismissButton: .default(Text("OK")) {
                            //faz algo quando some o alerta
                        })
                    }//alert
            }// if case error
        } //VStack
        .onAppear(perform: viewModel.fechUser)
        
        

    } // main View
}



#Preview {
    ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
}
