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
    func fetchAllCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
}

class NetworkManager: Networking {

    static let shared = NetworkManager()

    private init() {

    }

    func fetchAllCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        let requestMethod = "\(baseUrlString)/\(ServerAPIMethods.getAllCharacters)"
        AF.request(requestMethod)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    let decoded = self.decodeJSON(type: RootModel.self, from: value)
                    guard let characters = decoded else {
                        return completion(.failure(NetworkError.networkError))
                    }
                    completion(.success(characters.results))
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
