//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-17.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    //design partern Sigeton
    private init() {

    }
    
    func postUser (request: SignUpRequest) -> Future<Bool, AppError> {
        return Future { promise in
         
            WebService.call(path: .postUser, method: .post,  body: request) {
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
                    case .sucess(_): //_ forma de dizer ao swifit que nao vou usar a variavel
                        promise(.success(true))
                        //completion(true, nil)
                        break
                }
            }//call
        }
       
    }
    
    
    
}
