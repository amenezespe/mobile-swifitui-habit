//
//  ProfileView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-21.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    @State var email = "amenezes.pe@gmail.com"
    @State var cpf = "009.654.342-87"
    @State var phone = "(81) 98765-4488"
    @State var bithdaey = "20/10/1992"
    
    var disableDone : Bool {
        viewModel.fullNameValidation.failure
        || viewModel.phoneValidation.failure
        || viewModel.fullNameValidation.failure
    }
    
    
    @State var selectedGender: Gender? = .male
    
    var body: some View {
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
                            TextField("", text: $email)
                                .disabled(true)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        } //HStack
                        
                        
                        HStack {
                            Text("CPF")
                            Spacer()
                            TextField("", text: $cpf)
                                .disabled(true)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        } //HStack
                        
                        HStack {
                            Text("Número de celular")
                            Spacer()
                            TextField("Digite o Celular", text: $viewModel.phoneValidation.value)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        } //HStack
                        
                        if (viewModel.phoneValidation.failure) {
                            Text("Número de celular inválido!")
                                .foregroundColor(.red)
                        }
                        
                        HStack {
                            Text("Data de Nascimento")
                            Spacer()
                            TextField("Digite a Data de Nascimento", text: $viewModel.birthdayValidation.value)
                                .multilineTextAlignment(.trailing)
                        } //HStack
                        
                        
                        if (viewModel.birthdayValidation.failure) {
                            Text("Data de nascimento inválida!")
                                .foregroundColor(.red)
                        }
                        
                        NavigationLink(
                            destination: GenderSelectorView(selectedGender: $selectedGender,
                                                            title: "Escolha o gênero",
                                                            genders: Gender.allCases),
                            label: {
                                HStack {
                                    Text("Gênero")
                                    Spacer()
                                    Text(selectedGender?.rawValue ?? "")
                                }
                            })
                        
                    } //Section
                
                } //Form
                
            } //VStack
            .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "checkmark")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }) //Button
                .opacity(disableDone ? 0 : 1)
            ) //navigationBarItems
            
        } //NavigationView
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
