//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 27.05.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit
import SwiftSpinner

final class CharactersListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    private var characters: [Character] = []
    let viewModel = CharactersListViewModel(networkManager: NetworkManager.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.getData()
    }

    private func setupUI() {
        tableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Rick and Morty"
    }

}

extension CharactersListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell {
            cell.configureWith(character: characters[indexPath.row], atIndex: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
}

extension CharactersListViewController: CharactersListViewModelDelegate {
    func updateList(characters: [Character]) {
        self.characters = characters
        self.tableView.reloadData()
    }

    func showError(error: Error) {
           self.showAlert(with: "Ошибка!", and: error.localizedDescription)
       }

       func showSpinner(title: String) {
           SwiftSpinner.setTitleFont(UIFont(name: "Helvetica Neue", size: 16.0))
           SwiftSpinner.show(title, animated: true)
       }

       func hideSpinner() {
           SwiftSpinner.hide()
       }
}
