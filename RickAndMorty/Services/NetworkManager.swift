//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 27.05.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation
import Alamofire

protocol Networking {
    func fetchAllCharacters(completion: @escaping (Result<RootCharacter, Error>) -> Void)
    func fetchNextPageCharacters(urlString: String, completion: @escaping (Result<RootCharacter, Error>) -> Void)
}

class NetworkManager: Networking {

    func fetchAllCharacters(completion: @escaping (Result<RootCharacter, Error>) -> Void) {
        let requestMethod = "\(baseUrlString)/\(ServerAPIMethods.getAllCharacters)"
         print("fetchAllCharacters \(requestMethod)")
        getCharacters(urlString: requestMethod, completion: completion)
    }

    func fetchNextPageCharacters(urlString: String, completion: @escaping (Result<RootCharacter, Error>) -> Void) {
         print("urlString \(urlString)")
        getCharacters(urlString: urlString, completion: completion)
    }

    func getCharacters(urlString: String, completion: @escaping (Result<RootCharacter, Error>) -> Void) {
        let requestMethod = urlString
         print("getCharacters \(requestMethod)")
        AF.request(requestMethod)
            .validate()
            .responseData { response in
                 print("getCharacters \(response)")
                switch response.result {
                case .success(let value):
                    let decoded = self.decodeJSON(type: RootCharacter.self, from: value)
                    guard let characters = decoded else {
                        return completion(.failure(NetworkError.networkError))
                    }
                    completion(.success(characters))
                case .failure:
                    completion(.failure(NetworkError.networkError))
                }
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {
            return  nil
        }
        return response
    }
}
