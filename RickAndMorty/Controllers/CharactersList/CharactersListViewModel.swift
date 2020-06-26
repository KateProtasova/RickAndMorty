//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 24.06.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation
protocol CharactersListViewModelDelegate: class {
    func updateList(characters: RootCharacter)
    func showError(error: Error)
    func showSpinner(title: String)
    func hideSpinner()
}

protocol ViewModel {
    var delegate: CharactersListViewModelDelegate? { get set }
    var networkManager: Networking! { get }

    func getData()
    func refreshData()
    func getNextPage(urlString: String)

}

final class CharactersListViewModel: ViewModel {

    weak var delegate: CharactersListViewModelDelegate?
    var networkManager: Networking!

    func getData() {
        delegate?.showSpinner(title: "Получаем всех героев")
        networkManager.fetchAllCharacters { characters in
            self.delegate?.hideSpinner()
            switch characters {
            case .success(let value):
                self.delegate?.updateList(characters: value)
            case .failure(let error):
                self.delegate?.showError(error: error)
            }
        }
    }

    func refreshData() {
        networkManager.fetchAllCharacters { characters in
            switch characters {
            case .success(let value):
                self.delegate?.updateList(characters: value)
            case .failure(let error):
                self.delegate?.showError(error: error)
            }
        }
    }

    func getNextPage(urlString: String) {
        print(#function)
        networkManager.fetchNextPageCharacters(urlString: urlString) { characters in
            print("characters \(characters)")
            switch characters {
            case .success(let value):
                self.delegate?.updateList(characters: value)
            case .failure(let error):
                self.delegate?.showError(error: error)
            }
        }
    }
}
