//
//  WebService.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-07.
//

import Foundation

enum WebService {
    
    enum EndPoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        
        case postUser = "/users"
        case fetchUser = "/users/me"
        case login = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        case habits = "/users/me/habits"
        case habitValues = "/users/me/habits/%d/values"
        
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Method: String {
        case get
        case post
        case put
        case delete
        
    }
    
    enum Result {
        case sucess(Data)
        case failure(NetworkError, Data?)
    }
    
    private static func completUrl(path: String) -> URLRequest? {
        guard let url = URL(string: "\(EndPoint.base.rawValue)\(path)") else {return nil}
        return URLRequest(url: url)
    }
    

    public static func call(path: String,
                            method: Method,
                             contentType: ContentType,
                             data: Data?,
                             completion: @escaping (Result) -> Void) {
        
        guard var urlRequest = completUrl(path: path) else { return }
        
        //para verificar se o token esta gravado se for add no header da request
        
        // _ =  simula o cancelable, no casso essa chamada eh sincrona
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = data
                
                
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error)
                        completion(.failure(.internalServerError, nil))
                        return
                    }
                    
                    if let r = response as? HTTPURLResponse {
                        switch r.statusCode {
                            case 400:
                                completion(.failure(.badRequest, data))
                                break
                            case 401:
                                completion(.failure(.unauthorized, data))
                                break
                            case 200:
                                completion(.sucess(data))
                            break
                            default:
                                break
                        }
                    }
                    
                    
                    print("response\n")
                    print(response)
                    
                   
                }
                
                task.resume()
                
            } //sink
        
       
    }
    
    
    enum ContentType : String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
    }
    
    public static func call<T: Encodable>(path : String,
                                          method: Method = .get, //forma de passar o valor default .get
                                           body: T,
                                           completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
    
        call(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
        
    }
    

    public static func call<T: Encodable>(path : EndPoint,
                                          method: Method = .get, //forma de passar o valor default .get
                                           body: T,
                                           completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
    
        call(path: path.rawValue, method: method, contentType: .json, data: jsonData, completion: completion)
        
    }
    
    public static func call (path : EndPoint,
                                          method: Method = .get, //forma de passar o valor default .get
                                           completion: @escaping (Result) -> Void) {

        call(path: path.rawValue, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    public static func call (path : EndPoint,
                             method: Method = .post, //forma de passar o valor default .post para nao alterar o codigo
                              params: [URLQueryItem],
                              completion: @escaping (Result) -> Void) {
        guard var urlRequest = completUrl(path: path.rawValue) else { return }
        guard var absolutUrl = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absolutUrl)
        components?.queryItems = params
        
        call(path: path.rawValue,
             method: method,
             contentType: .formUrl,
             data: components?.query?.data(using: .utf8),
             completion: completion)
        
    }
    
}
