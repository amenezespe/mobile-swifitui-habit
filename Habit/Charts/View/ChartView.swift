//
//  ChartView.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-22.
//

import SwiftUI
import DGCharts

struct ChartView: View {
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
        
        ZStack {
            if case ChartUIState.loading = viewModel.uiState {
                ProgressView()
            } else {
                VStack {
                    if case ChartUIState.emptyChart = viewModel.uiState {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center )
                        
                        
                        
                        Text("Nenhum hábito encontrado :(")
                    } else if case ChartUIState.error(let msg) = viewModel.uiState {
                    
                    Text("")
                        .alert(isPresented: .constant(true)) {
                           Alert(title: Text("Sim"),
                                 primaryButton: .default(Text("Sim")) {
                                        //reconecta
                                    },
                                 secondaryButton: .cancel()
                           )
                        } //alert
                    } else { // ChartUIState.fullChart
                        
                        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 350)
                    } //else
                    
                } //VStack
                
               
            } //if
            
        } //ZStack
        .onAppear(perform: viewModel.onAppear)

    }//View
} //ChartView


// essa instrucao e para informar que UIKIt se comunicar com o SWIFITUI
//ou seja tem que codificar em UIKIT

//struct TestView: UIViewRepresentable {
//    typealias UIViewType = UILabel
//    
//    func makeUIView(context: Context) -> UILabel {
//      let lb = UILabel()
//        
//        lb.backgroundColor = UIColor.red
//        lb.text = "Olá"
//        
//    return lb
//        
//    }
//    
//    func updateUIView(_ uiView: UILabel, context: Context) {
//        
//    }
//}

#Preview {
    HabitDetailViewRouter.makeChartView(id: 1)
}
