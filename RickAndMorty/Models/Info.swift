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


    init(count: Int, pages: Int, next: String, prev: String) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}
