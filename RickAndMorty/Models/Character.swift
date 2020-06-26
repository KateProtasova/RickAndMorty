//
//  Character.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 27.05.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

final class Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String

}
