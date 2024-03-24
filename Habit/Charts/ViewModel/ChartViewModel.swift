//
//  ChartViewModel.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-23.
//

import Foundation
import SwiftUI
import DGCharts
import Combine

class ChartViewModel: ObservableObject {
    
    @Published var uiState = ChartUIState.loading
    
    @Published var entries: [ChartDataEntry] = []
    
    @Published var dates: [String] = []
    
    private var cancellable: AnyCancellable?
    
    private let habitId: Int
    private let interactor: ChartInteractor
    
    init(habitId: Int, interactor: ChartInteractor) {
        self.habitId = habitId
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }

    func onAppear() {
        cancellable = interactor.fetchHabitValues(habitId: habitId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch (completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message ?? "Erro desconnhecido!")
                    break
                case .finished:
                    break
                }
                
                
            }, receiveValue: {response in
                
                if response.isEmpty {
                    self.uiState = .emptyChart
                } else {
                    self.dates = response.map { $0.createdDate }
                    
                    //0..N [HabitValueResponse] // simula um for i na lista pegando o i = index e o res.value = response(i).value
                    self.entries = zip(response.startIndex..<response.endIndex, response).map { index, res in
                        ChartDataEntry(x: Double(index), y: Double(res.value))
                    }
                    
                    self.uiState = .fullChart
                    print()
                   
                }
            })
    }
    
    
    
    
    
    
}
