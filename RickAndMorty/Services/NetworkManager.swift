//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 27.05.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {

    static let shared = NetworkManager()

    private init() {

    }

    private let urlString = "https://rickandmortyapi.com/api/character/"

    func fetchAllCharacters(completion: @escaping ([Character]?) -> Void) {
        AF.request(urlString)
            .validate()
            .responseData { response in

                switch response.result {
                case .success(let value):
                    let decoded = self.decodeJSON(type: RootModel.self, from: value)
                    completion(decoded?.results)
                case .failure(let error):
                    print(error)
                }
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {
            return nil
        }
        return response
    }
}
