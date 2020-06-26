//
//  Info.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 26.06.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

final class Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
