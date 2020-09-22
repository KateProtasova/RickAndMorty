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


    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.status = name
        self.species = name
        self.type = name
        self.gender = name
        self.origin = Location(name: name, url: name)
        self.location = Location(name: name, url: name)
        self.image = name
        self.episode = [name]
        self.url = name
        self.created = name
    }

}
