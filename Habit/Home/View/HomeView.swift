//
//  HomeView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-03.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel : HomeViewModel
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            viewModel.habitView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Hábitos")
                }.tag(0)
            Text("Conteudo de graficos \(selection)")
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Graficos")
                }.tag(1)
            viewModel.profileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag(2)
        }
        .background(Color.white)
        .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
    
}


let homeViewModel = HomeViewModel()

#Preview {
    HomeView(viewModel: homeViewModel)
}


