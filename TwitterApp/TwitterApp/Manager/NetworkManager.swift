//
//  NetworkManager.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 03/01/2021.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseURL = URLs.baseUrlWithToken
    
    
    private init() {}
    
   
    func getUser(for username: String, completed: @escaping(Result<User, TwitError>) -> Void) {
        let endpoint = baseURL + URLs.endUrlReturnUserInfo
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.wrongUrl))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error { completed(.failure(.error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.response))
                return
            }
            
            guard let data = data else {
                completed(.failure(.data))
                return
                
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.data))
            }
        }
        dataTask.resume()
    }
}
