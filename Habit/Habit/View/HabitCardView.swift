//
//  HabitCardView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import SwiftUI
import Combine

struct HabitCardView: View {
    let viewModel: HabitCardViewModel
    
    @State private var action = false
    
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink (
                destination: viewModel.habitDetailView(),
                isActive: self.$action,
                label: {
                    EmptyView()
                })
            
            Button(action: {
                self.action = true
            },label: {
                
                HStack{
                    ImageView(url: "https://via.placeholder.com/150")
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 32, height: 32)
                        .clipped()
                        
//                        .padding(.horizontal, 8)
                    
//                    Image(systemName: "pencil")
//                        .padding(.horizontal, 8)
                    
                    Spacer()
                    
                    HStack(alignment: .top) {

                        Spacer()


                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.name)
                                .foregroundColor(.blue)
                            
                            Text(viewModel.name)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                        } //VStack
                        .frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Registrado")
                                .foregroundColor(.blue)
                                .bold()
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            
                            Text(viewModel.value)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                .bold()
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        } //VStack 2
                        
                        Spacer()
                        
                    } //HStack
                    Spacer()
//                    Rectangle()
//                        .frame(width: 8)
//                        .foregroundColor(viewModel.state)
                }//HStack 1
                .padding()
                .cornerRadius(4.0)
            })
            
            Rectangle()
                .frame(width: 8)
                .foregroundColor(viewModel.state)
//                .padding(.top)
//                .padding(.bottom)
            
        
            
            
        } //ZStack
        .background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color.blue, lineWidth: 1.4)
                .shadow(color: .gray, radius: 2, x: 2.0, y: 2.0)
        ) //background
            .padding(.horizontal, 4)
            .padding(.vertical, 8)
        
    }
}


let viewModelHabitCard = HabitCardViewModel(id: 1,
                                            icon: "https://via.placeholder.com/150",
                                            date: "01/01/2021 00:00:00",
                                            name: "Tocar guitarra",
                                            label: "Horas",
                                            value: "2",
                                            state: .green,
                                            habitPublisher: PassthroughSubject<Bool, Never>())

#Preview {
    NavigationView{
        List{
            HabitCardView(viewModel: viewModelHabitCard)
            HabitCardView(viewModel: viewModelHabitCard)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .navigationTitle("Habitos")
    }
}
