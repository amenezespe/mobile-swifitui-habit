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
        case updateUser = "/users/%d"
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
    
    enum ContentType : String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
        case multipart = "multipart/form-data"
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
                            boundary: String = "",
                            completion: @escaping (Result) -> Void) {
        
        guard var urlRequest = completUrl(path: path) else { return }
        
        //para verificar se o token esta gravado se for add no header da request
        
        // _ =  simula o cancelable, no casso essa chamada eh sincrona
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                
                if contentType == .multipart {
                    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                } else {
                    urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
                }
                
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                
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
                        case 201:
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
    
    public static func call<T: Encodable>(path : String,
                                          method: Method = .get, //forma de passar o valor default .get
                                          body: T,
                                          completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        call(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
        
    }
    
    
    public static func call(path : String,
                            method: Method = .get, //forma de passar o valor default .get
                            completion: @escaping (Result) -> Void) {
        
        call(path: path, method: method, contentType: .json, data: nil, completion: completion)
        
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
                             data: Data? = nil,
                             completion: @escaping (Result) -> Void) {
        guard var urlRequest = completUrl(path: path.rawValue) else { return }
        guard var absolutUrl = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absolutUrl)
        components?.queryItems = params
        
        let boundary = "Boundary-\(NSUUID().uuidString)"
        let hasData = data != nil
        
        let newData = hasData ? createBodyWithparameters(params: params, data: data!, boundary: boundary) : components?.query?.data(using: .utf8)
        
        call(path: path.rawValue,
             method: method,
             contentType: hasData ? .multipart : .formUrl,
             data: newData,
             boundary: boundary,
             completion: completion)
        
    }
    
    
    private static func createBodyWithparameters(params: [URLQueryItem], data: Data, boundary: String) -> Data {
        let body = NSMutableData()
        
        for param in params {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(param.name)\"\r\n\r\n")
            body.appendString("\(param.value!)\r\n")
        }
        
        let filename = "img.jpg"
        let mimeType = "image/jpeg"
        //imagem
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        
        //anexando o binario da foto
        body.append(data)
        
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        
        //comando para imprimir na console
        // p print(String(data: body as Data, encoding: .utf8))
        
        return body as Data
        
    }
}

extension NSMutableData {
    func appendString (_ string: String) {
        append(string.data(using: .utf8, allowLossyConversion: true)!)
    }
}
