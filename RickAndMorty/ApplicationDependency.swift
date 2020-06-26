//
//  ApplicationDependency.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 26.06.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation
import DITranquillity

class ApplicationDependency: DIFramework {

    static let container: DIContainer = {
        let container = DIContainer()
        container.append(framework: ApplicationDependency.self)

        assert(container.validate(checkGraphCycles: true), "Invalid dependency graph")

        return container
    }()

    static func load(container: DIContainer) {

        container.registerStoryboard(name: "Main")
            .as(check: UIStoryboard.self, tag: CharactersListViewController.self) { $0 }
            .as(check: UIStoryboard.self, tag: DetailsCharacterViewController.self) { $0 }

        container.register(NetworkManager.init)
            .as(check: Networking.self) { $0 }

        container.register(CharactersListViewModel.init)
            .as(check: ViewModel.self) { $0 }
            .injection(\.networkManager)

        container.register(CharactersListViewController.self)
            .injection(\.viewModel)
            .lifetime(.objectGraph)
    }
}
