//
//  HabitCreateRemoteDataSource.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-26.
//

import Foundation
import Combine

class HabitCreateRemoteDataSource {
    
    static var shared: HabitCreateRemoteDataSource = HabitCreateRemoteDataSource()
    
    //design partern Sigeton
    private init() {

    }
    
    func save(request: HabitCreateRequest) -> Future<Void, AppError> {
        return Future { promise in
            
            WebService.call(path: .habits, params: [
                    URLQueryItem(name: "name", value: request.name),
                    URLQueryItem(name: "label", value: request.label)
                    ], data: request.imageData) {
                result in
                
                switch result {
                    case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                                let decoder = JSONDecoder()
                                let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                                //completion(nil, response)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Error desconhecido no servidor")))
                            }
                        }
                        break
                    case .sucess(_):
                        //retorno de uma chamada void :) 
                        promise(.success( () ))
                        break
//                    default:
//                        break
                                
                }
            } //call
        } //future
    }
    
    
    
}

