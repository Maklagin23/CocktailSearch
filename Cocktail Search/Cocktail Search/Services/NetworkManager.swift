//
//  NetworkManager.swift
//  Cocktail Search
//
//  Created by Maksim Maklagin on 31.01.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchDrinks(form url: String, completion: @escaping(Result<Drink, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: Drink.self) { dataResponse in
                
                switch dataResponse.result {
                    case .success(let data):
                        completion(.success(data))
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func fetchImage(from url: URL?, completion: @escaping(Result<Data, AFError>) -> Void) {
        guard let url = url else { return }
        
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                
                switch dataResponse.result {
                    case .success(let data):
                        completion(.success(data))
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
                
            }
    }
    
}
