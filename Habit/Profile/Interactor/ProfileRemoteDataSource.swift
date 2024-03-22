//
//  ProfileRemoteDataSource.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-22.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    
    static var shared: ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    //design partern Sigeton
    private init() {

    }
    
    func fetchUser () -> Future<ProfileResponse, AppError> {
        return Future { promise in
         
            WebService.call(path: .fetchUser, method: .get) {
                result in
                
                switch result {
                    case .failure(let error, let data):
                    if let data = data {
                            if error == .badRequest {
                                let decoder = JSONDecoder()
                                let response = try? decoder.decode(ErrorResponse.self, from: data)
                                promise(.failure(AppError.response(message: response?.detail ?? "Erro Desconhecido!")))
                            }
                        }
                        break
                    case .sucess(let data): //_ forma de dizer ao swifit que nao vou usar a variavel
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ProfileResponse.self, from: data)
                        //completion(response, nil)
                        guard let response = response else {
                            print("Log: Error parser \(String(data:data, encoding: .utf8)!)")
                        return
                        }
                        promise(.success(response))
                        break
                }
            }//call
        }
       
    }
    
    
    
}
