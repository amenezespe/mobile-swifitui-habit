//
//  HabitDetailRemoteDataSource.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import Foundation
import Combine

class HabitDetailRemoteDataSource {
    
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    //design partern Sigeton
    private init() {

    }
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool, AppError> {
        return Future<Bool, AppError> { promise in
            
            let path = String(format: WebService.EndPoint.habitValues.rawValue, habitId)

            WebService.call(path: path, method: .post, body: request) {
                result in
                
                switch result {
                    case .failure(_, let data):
                        if let data = data {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                           
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Error desconhecido no servidor")))
                        }
                        break
                    case .sucess(_):
                        promise(.success(true))
                        break

                    
                }
            } //call
        } //future
    }
    
    
    
}
