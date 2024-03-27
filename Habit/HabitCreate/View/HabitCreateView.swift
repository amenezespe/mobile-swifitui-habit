//
//  HabitCreateView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-25.
//


import SwiftUI

struct HabitCreateView: View {
 
    @ObservedObject var viewModel: HabitCreateViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State private var shouldPresentCamera = false
    
    init(viewModel: HabitCreateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
           
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
              
                Button(action: {
                    //mostrar as cameras
                    self.shouldPresentCamera = true
                    
                    
                }, label: {
                    VStack {
                        viewModel.image!
                            .resizable()
                            .scaledToFit()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .foregroundColor(.gray)
                        
                        Text("Clique Aqui para enviar")
                            .foregroundColor(.blue)
                    }//VStack
                }) //label
                .padding(.bottom, 12)
                .sheet(isPresented: $shouldPresentCamera) {
                    ImagePickerView(image: self.$viewModel.image,
                                    imageData: self.$viewModel.imageData,
                                    isPresented: $shouldPresentCamera,
                                    sourceType: .camera)
                }
                
        
            } //VStack
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                TextField("Escreva aqui o nome do hábito", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                
            } //VStack
            .padding(.horizontal, 32)
            
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                TextField("Escreva aqui a unidade de medida", text: $viewModel.label)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                
            } //VStack
            .padding(.horizontal, 32)
            
            LoadingButtonView(
                action: {
                    viewModel.save()
                },
                text: "Salvar",
                showProgressBar: self.viewModel.uiState == .loading,
                disabled: self.viewModel.name.isEmpty ||  self.viewModel.label.isEmpty)
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
let viewModelHabitCreate = HabitCreateViewModel(interactor: HabitCreateInteractor())

#Preview {
    HabitCreateView(viewModel: viewModelHabitCreate)
}
