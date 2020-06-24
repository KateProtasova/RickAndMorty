//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 24.06.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation
protocol CharactersListViewModelDelegate: class {
    func updateList(characters: [Character])
    func showError(error: Error)
    func showSpinner(title: String)
    func hideSpinner()
}

final class CharactersListViewModel {

    weak var delegate: CharactersListViewModelDelegate?
    private let networkManager: Networking

    init(networkManager: Networking) {
        self.networkManager = networkManager
    }

    func getData() {
        networkManager.fetchAllCharacters { characters in
            self.delegate?.updateList(characters: characters ?? [])
        }
    }
}
