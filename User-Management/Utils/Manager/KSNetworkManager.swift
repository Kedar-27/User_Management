//
//  KSNetworkManager.swift
//  User-Management
//
//  Created by Kedar Sukerkar on 21/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `CONNECT` method.
    public static let connect = HTTPMethod(rawValue: "CONNECT")
    /// `DELETE` method.
    public static let delete = HTTPMethod(rawValue: "DELETE")
    /// `GET` method.
    public static let get = HTTPMethod(rawValue: "GET")
    /// `HEAD` method.
    public static let head = HTTPMethod(rawValue: "HEAD")
    /// `OPTIONS` method.
    public static let options = HTTPMethod(rawValue: "OPTIONS")
    /// `PATCH` method.
    public static let patch = HTTPMethod(rawValue: "PATCH")
    /// `POST` method.
    public static let post = HTTPMethod(rawValue: "POST")
    /// `PUT` method.
    public static let put = HTTPMethod(rawValue: "PUT")
    /// `TRACE` method.
    public static let trace = HTTPMethod(rawValue: "TRACE")
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}




public enum NetworkError: LocalizedError{
    
    case noInternet
    case parsingError
    case noDataFound
    
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return NSLocalizedString("No internet found.", comment: "No Internet Error")
        case .parsingError:
            return NSLocalizedString("Json parsing failed", comment: "JSON Parsing Error")
        case .noDataFound:
            return NSLocalizedString("No data found", comment: "No data found Error")
        }
    }
}





public class KSNetworkManager: NSObject {
    
    // MARK: - Initializer
    public static let shared = KSNetworkManager()
    private override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 60
        
        self.KSSession = URLSession(configuration: configuration)
        
    }
    
    // MARK: - Properties
    public var serverURL = ""
    public let KSSession: URLSession?
    
    
    
    // MARK: - Response Closures
    public typealias responseModel = (Result<Data,Error>) -> Void
    
    
    
    // MARK: - Request Helpers
    public func sendRequest(baseUrl:String = KSNetworkManager.shared.serverURL,
                            methodType:HTTPMethod,
                            apiName:String,
                            parameters:[String:Any]?,
                            headers:[String:Any]?,
                            completionHandler:@escaping responseModel){
        
        
        
        
        guard let urlString = URL(string: baseUrl + apiName) else{return}
        
        print(urlString)
        
        var request = URLRequest(url: urlString, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 12)
        request.httpMethod = methodType.rawValue
        
        guard try! Reachability().connection != .unavailable else{
            completionHandler(.failure(NetworkError.noInternet))
            return
        }
        DispatchQueue.global(qos: .background).async {[weak self]in
            self?.KSSession?.dataTask(with: request, completionHandler: { (data, response, error) in
                
                guard error == nil, let data = data else{
                    completionHandler(.failure(error!))
                    return
                }
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }

                
                
                
            }).resume()
            
        }
        
        
    }
    
    
    
    
    
    public func getJSONDecodedData<T: Codable>(from data: Data, completion: @escaping (Result<T, Error>)-> Void){
        
        DispatchQueue.global(qos: .background).async {
            do {
                let parsedJSON = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(parsedJSON))
                }

            } catch let jsonErr {
                DispatchQueue.main.async {
                    completion(.failure(jsonErr))
                }

                
                print("failed to decode, \(jsonErr)")
            }
        }
        
        
        
    }
    
}
