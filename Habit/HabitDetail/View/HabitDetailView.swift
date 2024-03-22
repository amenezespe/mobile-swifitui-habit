//
//  HabitDetailView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import SwiftUI

struct HabitDetailView: View {
 
    @ObservedObject var viewModel: HabitDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
           
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Text(viewModel.name)
                    .foregroundColor(.blue)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                
                Text("Unidade: \(viewModel.label)")
                
            } //VStack
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                TextField("Escreva aqui o valor conquistado", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                    
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                
            } //VStack
            .padding(.horizontal, 32)
           
            Text("Os registros devem ser feitos em ate 24 horas. \nHábitos se constroem todos os dias :)")
            
            LoadingButtonView(
                action: {
                    viewModel.save()
                },
                text: "Salvar",
                showProgressBar: self.viewModel.uiState == .loading,
                disabled: self.viewModel.value.isEmpty)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            
            Button("Cancelar"){
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.easeOut(duration: 2)) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                //dimiss - voltar para a tela de listagem
                
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            
            Spacer()
            
        } //ScrollView
        .padding(.horizontal, 8)
        .padding(.top, 32)

    }
}
let viewModelHabitDetail = HabitDetailViewModel(id: 1, name: "Correr", label: "Correr 5km", interactor: HabitDetailInteractor())

#Preview {
    HabitDetailView(viewModel: viewModelHabitDetail)
}
