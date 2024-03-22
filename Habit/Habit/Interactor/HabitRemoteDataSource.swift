//
//  HabitRemoteDataSource.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import Foundation
import Combine

class HabitRemoteDataSource {
    
    static var shared: HabitRemoteDataSource = HabitRemoteDataSource()
    
    //design partern Sigeton
    private init() {

    }
    
    func fechHabits() -> Future<[HabitResponse], AppError> {
        return Future<[HabitResponse], AppError> { promise in
            
            WebService.call(path: .habits, method: .get) {
                result in
                
                switch result {
                    case .failure(_, let data):
                        if let data = data {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Error desconhecido no servidor")))
                        }
                        break
                    case .sucess(let data):
                        let decoder = JSONDecoder()
                    let response = try? decoder.decode([HabitResponse].self, from: data)
                        //completion(response, nil)
                        guard let response = response else {
                            print("Log: Error parser \(String(data:data, encoding: .utf8)!)")
                            return
                        }
                        promise(.success(response))
                        break
//                    default:
//                        break
                    
                }
            } //call
        } //future
    }
    
    
    
}
