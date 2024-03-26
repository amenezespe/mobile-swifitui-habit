//
//  HabitViewModel.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-18.
//

import Foundation
import Combine
import SwiftUI

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUiState = .loading
    
    @Published var title = "Atenção"
    
    @Published var description = "Você está atrasado nos habitos"
    
    @Published var headline = "Fique Ligado"
    
    @Published var opened = false
    
    private var cancellableRequest: AnyCancellable?
    private let interactor: HabitInteractor
    let isChart: Bool
    
    private let habitPublisher = PassthroughSubject<Bool, Never>()
    private var cancellableNotify: AnyCancellable?
    
    
    init(isChart: Bool, interactor: HabitInteractor) {
        self.isChart = isChart
        self.interactor = interactor
        cancellableNotify = habitPublisher.sink(receiveValue: {saved in
            print("saved", saved)
            self.onApper()
            
        })
    }
    
    deinit{
        cancellableRequest?.cancel()
        cancellableNotify?.cancel()
    }
    
    func onApper() {
        self.opened = true
        
        self.uiState = .loading
        cancellableRequest = interactor.fechHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                //acontece o error
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message ?? "Erro desconnhecido!")
                    break
                case .finished:
                    break
                }
                
            }, receiveValue: {response in
                
                    
                if response.isEmpty {
                    self.uiState = .emptyList
                    self.title = ""
                    self.headline = ""
                    self.description = "Coce ainda não possui habitos"
                } else {
                    self.uiState = .fullList(
                        response.map {
                            
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-mm-dd'T'HH:mm:ss", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            var state = Color.green
                            self.title = "Muito Bom"
                            self.headline = "Seus habitos estão em dia"
                            self.description = ""
                            
                            let dateConverted = $0.lastDate?.toDate(sourcePattern: "yyyy-mm-dd'T'HH:mm:ss") ?? Date()
                            
                            if dateConverted < Date() {
                                print("lastDate", lastDate)
                                state = .red
                                self.title =  "Atenção"
                                self.headline = "Fique Ligado"
                                self.description = "Você está atrasado nos habitos"
                            }
                            
                            return HabitCardViewModel(id: $0.id,
                                                      icon: $0.iconUrl ?? "",
                                                      date: lastDate,
                                                      name: $0.name,
                                                      label: $0.label,
                                                      value: "\($0.value ?? 0)",
                                                      state: state,
                                                      habitPublisher: self.habitPublisher)
                        }
                    )
                    
                    
                    
                    
                }
            })
    
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            var rows: [HabitCardViewModel] = []
//
//            rows.append(HabitCardViewModel(id: 1,
//                                           icon: "https://via.placeholder.com/150",
//                                           date: "01/01/2021 00:00:00",
//                                           name: "Tocar guitarra",
//                                           label: "Horas",
//                                           value: "2",
//                                           state: .green))
//            rows.append(HabitCardViewModel(id: 2,
//                                           icon: "https://via.placeholder.com/150",
//                                           date: "01/01/2021 00:00:00",
//                                           name: "Fazer acaminhada",
//                                           label: "Km",
//                                           value: "5",
//                                           state: .green))
//            rows.append(HabitCardViewModel(id: 3,
//                                           icon: "https://via.placeholder.com/150",
//                                           date: "01/01/2021 00:00:00",
//                                           name: "Tocar guitarra",
//                                           label: "Horas",
//                                           value: "2",
//                                           state: .green))
//            rows.append(HabitCardViewModel(id: 4,
//                                           icon: "https://via.placeholder.com/150",
//                                           date: "01/01/2021 00:00:00",
//                                           name: "Tocar guitarra",
//                                           label: "Horas",
//                                           value: "2",
//                                           state: .green))
//            rows.append(HabitCardViewModel(id: 5,
//                                           icon: "https://via.placeholder.com/150",
//                                           date: "01/01/2021 00:00:00",
//                                           name: "Tocar guitarra",
//                                           label: "Horas",
//                                           value: "2",
//                                           state: .green))
//            
//            
           // self.uiState = .fullList(rows)
//            print("ENTREI")
//            self.uiState = .error("Falha interna no servidor!")
        }
}

extension HabitViewModel {
    func habitCreateView() -> some View {
        return HabitViewRouter.habitCreateView(habitPublisher: habitPublisher)
    }
}
