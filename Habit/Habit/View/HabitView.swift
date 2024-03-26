//
//  HabitView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-18.
//

import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitUiState.loading = viewModel.uiState {
                progress

            } else {
                
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            
                            if (!viewModel.isChart) {
                                topContainer
                                
                                addButton
                            }
                           
                            
                            if case HabitUiState.emptyList = viewModel.uiState {
                                Spacer(minLength: 60)
                                
                                VStack {
                                    
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center )
                                        
                                    
                                    
                                    Text("Nenhum hábito encontrado :(")
                                }
                                
                            } else if case HabitUiState.fullList(let rows) = viewModel.uiState {
                                //LazyVStack deve ser usadno ao inves de lista pq estamos em um componente de scrolling
                                LazyVStack{
                                    ForEach(rows) {row in
                                        HabitCardView.init(viewModel: row, isChart: viewModel.isChart)
                                    }
                                } //LazyVStack
                                .padding(.horizontal, 14)
                                
                                
                            } else if case HabitUiState.error(let msg) = viewModel.uiState {
                                
                                Text("")
                                    .alert(isPresented: .constant(true)) {
                                       Alert(title: Text("Sim"),
                                             primaryButton: .default(Text("Sim")) {
                                                    //reconecta
                                                },
                                             secondaryButton: .cancel()
                                       )
                                    } //alert
                            }// else if
                            
                        } //VStack
                       
                    } //ScrollView
                    .navigationTitle("Meus Hábitos")
                   
                    
                }//NavigationView
                
                
            }//else
        } //Zstack
       
        .onAppear{
            //opcional para no caso de nao querer atualizar a consulta se trocar de tela
            if !viewModel.opened {
                viewModel.onApper()
            }
            
        }
    } //view
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

extension HabitView {
    var topContainer: some View {
        VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
            
            Text(viewModel.title)
                .font(.title).bold()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            Text(viewModel.headline)
                .font(.title3).bold()
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.description)
                .font(.subheadline).bold()
                .foregroundColor(Color("textColor"))
            
        } //vStak
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding(.vertical, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}


extension HabitView {
    var addButton: some View {
        NavigationLink(
            destination: viewModel.habitCreateView()
                .frame(maxWidth: .infinity, maxHeight: .infinity))
            {
                Label("Criar Habito", systemImage: "plus.app")
    
                    .modifier(ButtonStyle())
            }
            .padding(.horizontal, 16)
            
    } //View
    
}


let viewModelHabit = HabitViewModel(isChart: false, interactor: HabitInteractor())

#Preview {
    HomeViewRouter.makeHabitView(viewModel: viewModelHabit)
}
