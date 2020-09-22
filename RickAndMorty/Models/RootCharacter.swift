//
//  RootCharacter.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 26.06.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

final class RootCharacter: Codable {
    let info: Info
    let results: [Character]

    init(info: Info, results: [Character]) {
        self.info = info
        self.results = results
    }
}
