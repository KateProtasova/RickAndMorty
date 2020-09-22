//
//  CharactersListTests.swift
//  CharactersListTests
//
//  Created by Екатерина Протасова on 01.07.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import XCTest
@testable import RickAndMorty

//class MockView: CharactersListViewModelDelegate {
//    let root = RootCharacter(info: Info(count: 2, pages: 1, next: "", prev: ""), results: [Character(id: 1, name: "foo"),  Character(id: 2, name: "foo")])
//    func updateList(characters: RootCharacter) {
//
//    }
//
//    func showError(error: Error) {
//
//    }
//
//    func showSpinner(title: String) {
//
//    }
//
//    func hideSpinner() {
//
//    }
//
//}

class MockNetworkManager: Networking {

    var fetchAllCharactersCounter: Int = 0
    var isError = false

    func fetchAllCharacters(completion: @escaping (Result<RootCharacter, Error>) -> Void) {
        fetchAllCharactersCounter += 1
        if !isError {
        let root = RootCharacter(info: Info(count: 2, pages: 1, next: "", prev: ""), results: [Character(id: 1, name: "foo"),  Character(id: 2, name: "foo")])
        completion(.success(root))
        } else {
            completion(.failure(NetworkError.networkError))
        }
    }

    func fetchNextPageCharacters(urlString: String, completion: @escaping (Result<RootCharacter, Error>) -> Void) {

    }
}

class ModelDelegateMock: CharactersListViewModelDelegate {

    var updateListCounter = 0
    var rootChars: RootCharacter?

    func updateList(characters: RootCharacter) {
        rootChars = characters
        updateListCounter += 1
    }

    var showErrorCounter = 0
    func showError(error: Error) {

    }

    func showSpinner(title: String) {

    }

    func hideSpinner() {

    }


}

class CharactersListViewModelTests: XCTestCase {

    var network: MockNetworkManager!
    var delegate: ModelDelegateMock!

    override func setUp() {
        network = MockNetworkManager()
        delegate = ModelDelegateMock()
    }

    override func tearDown() {
        network = nil
        delegate = nil
    }

    func testGoodData() {
        //Given
        let sut = CharactersListViewModel()
        sut.networkManager = network  
        sut.delegate = delegate

        //When
        sut.getData()

        //Then
        XCTAssertTrue(network.fetchAllCharactersCounter == 1)
        XCTAssertTrue(delegate.updateListCounter == 1)
    }

    func testErrorData() {
        //Given
        let sut = CharactersListViewModel()
        network.isError = true
        sut.networkManager = network
        sut.delegate = delegate

        //When
        sut.getData()

        //Then
        XCTAssertTrue(network.fetchAllCharactersCounter == 1)
        XCTAssertTrue(delegate.updateListCounter == 0)
    }
}
