//
//  HabitDetailViewModel.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import SwiftUI
import Combine

class HabitDetailViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUiState = .none
    @Published var value =  ""
    
    private var cancellable: AnyCancellable?
    
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
    
    let id: Int
    let name: String
    let label: String
    let interactor: HabitDetailInteractor
    
    init(id: Int, name: String, label: String, interactor: HabitDetailInteractor) {
        self.id = id
        self.name = name
        self.label = label
        self.interactor = interactor;
    }
    
    deinit{
        cancellable?.cancel()
        //faz um loop para cancelar todos os cancellables
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    
    func save () {
        self.uiState = .loading
        
        cancellable = interactor.save(habitId: id, request: HabitValueRequest(value: value))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                //error finished
                switch(completion) {
                    case .failure(let appError):
                        self.uiState = .error(appError.message ?? "Erro desconnhecido!")
                        break
                    case .finished:
                        break
                }
                
            },receiveValue: {created in
                if (created) {
                    self.habitPublisher?.send(created)
                }
                
            } )
    }

}
