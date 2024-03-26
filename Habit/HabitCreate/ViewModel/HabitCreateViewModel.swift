//
//  HabitCreateViewModel.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-25.
//

import Foundation
import SwiftUI
import Combine


class HabitCreateViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUiState = .none
    @Published var name =  ""
    @Published var label =  ""
    
    @Published var image: Image? = Image(systemName: "camera.fill")
    @Published var imageData: Data? = nil
    
    private var cancellable: AnyCancellable?
    
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?

    let interactor: HabitCreateInteractor
    
    init(interactor: HabitCreateInteractor) {
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
        
        cancellable = interactor
            .save(habitCreateRequest: HabitCreateRequest(imageData: imageData, name: name, label: label))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                //acontece o error
                switch(completion) {
                    case .failure(let appError):
                    self.uiState = .error(appError.message ?? "Erro desconnhecido!")
                        break
                    case .finished:
                        break
                }
                
            }, receiveValue: {
                self.uiState = .success
                //envia que foi ok para esconder a tela 
                self.habitPublisher?.send(true)
            })
    }

}
