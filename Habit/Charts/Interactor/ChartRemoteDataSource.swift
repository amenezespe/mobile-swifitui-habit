//
//  ChartRemoteDataSource.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-24.
//

import Foundation
import Combine

class ChartRemoteDataSource {
    
    static var shared: ChartRemoteDataSource = ChartRemoteDataSource()
    
    //design partern Sigeton
    private init() {

    }
    
    func fetchHabitValues (habitId: Int) -> Future<[HabitValuesResponse], AppError> {
        return Future { promise in
         
            let path = String(format: WebService.EndPoint.habitValues.rawValue, habitId)

            WebService.call(path: path, method: .get) {
                result in
                
                switch result {
                    case .failure(_, let data):
                    if let data = data {
                        
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro Desconhecido!")))
                        
                    }
                        break
                    case .sucess(let data): //_ forma de dizer ao swifit que nao vou usar a variavel
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode([HabitValuesResponse].self, from: data)
                        //completion(response, nil)
                        guard let res = response else {
                            print("Log: Error parser \(String(data:data, encoding: .utf8)!)")
                        return
                        }
                        promise(.success(res))
                        break
                }
            }//call
        }//func
    
    }
}

