//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-21.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var uiState: ProfileUIState = .none
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthDayValidation()
    
    var userId: Int?
    @Published var email = ""
    @Published var document = ""
    @Published var gender: Gender?
    
    private var cancellable: AnyCancellable?
    
    private var updateUserCancellable: AnyCancellable?
    
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        updateUserCancellable?.cancel()
    }
    
    func fechUser() {
        cancellable = interactor.fetchUser()
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
            }, receiveValue: {response in
                
               
                self.userId = response.id
                self.email = response.email
                self.document = response.document
                self.gender = Gender.allCases[response.gender]
                self.fullNameValidation.value = response.fullname
                self.phoneValidation.value = response.phone
                self.birthdayValidation.value = response.birthday.toDate(sourcePattern: "yyyy-MM-dd", destPattern: "dd/MM/yyyy") ?? ""
                self.uiState = .success
            })
    }
    
    
    func updateUser() {
        self.uiState = .updateLoading
        
        guard let userId = userId,
              let gender = gender else { return }
        
        guard let newBirthday = self.birthdayValidation.value.toDate(sourcePattern: "dd/MM/yyyy", destPattern: "yyyy-MM-dd") else {
            self.uiState = .updateError("Data inválida \(birthdayValidation.value)")
            return
        }
        
        
        cancellable = interactor.updatehUser(userId: userId, request: ProfileRequest(fullname: self.fullNameValidation.value,
                                                                                     phone: self.phoneValidation.value,
                                                                                     birthday: newBirthday,
                                                                                     gender: gender.index))
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
        }, receiveValue: {response in
            self.uiState = .updateSuccess
        })
    }
    
}


class FullNameValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "Teste" {
        didSet {
            failure = value.count < 3
        } //didSet
    } //value
    
}


class PhoneValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "11912341234" {
        didSet {
            failure = value.count < 14 || value.count >= 15
        } //didSet
    } //value
    
}

class BirthDayValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "20/02/1990" {
        didSet {
            failure = value.count != 10
        } //didSet
    } //value
    
}
