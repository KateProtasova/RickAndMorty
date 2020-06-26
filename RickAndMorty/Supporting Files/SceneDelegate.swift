//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 27.05.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let storyboard: UIStoryboard = ApplicationDependency.container.resolve(tag: CharactersListViewController.self)
        window?.rootViewController = storyboard.instantiateInitialViewController()

        window?.makeKeyAndVisible()
    }
}
