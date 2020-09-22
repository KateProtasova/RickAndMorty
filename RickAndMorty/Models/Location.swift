//
//  Location.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 26.06.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

final class Location: Codable {
    let name: String
    let url: String

    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
