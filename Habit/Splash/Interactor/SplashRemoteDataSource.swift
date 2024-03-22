//
//  SplashRemoteDataSource.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-18.
//

import Foundation
import Combine

class SplashRemoteDataSource {
    
    static var shared: SplashRemoteDataSource = SplashRemoteDataSource()
    
    //design partern Sigeton
    private init() {

    }
    
    func refreshToken(request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse, AppError> { promise in
            
            WebService.call(path: .refreshToken, method: .put, body: request) {
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
                    case .sucess(let data):
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInResponse.self, from: data)
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
