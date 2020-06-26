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
    @IBOutlet private var loadingView: UIView!

    private var nextUrl: String? = ""
    private var characters: [Character] = []

    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()

    let viewModel = CharactersListViewModel(networkManager: NetworkManager.shared)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.getData()

    }

    @objc
    private func refresh(sender: UIRefreshControl) {
        viewModel.refreshData()
        //sender.endRefreshing()
    }

    private func setupUI() {
        tableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
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

extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailsCharacterViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsCharacterViewController") as? DetailsCharacterViewController {
            detailsCharacterViewController.character = characters[indexPath.row]
            navigationController?.pushViewController(detailsCharacterViewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = characters.count
        if  count > 1 {
            let lastElement = count - 1
            if indexPath.row == lastElement {
                guard let urlString = nextUrl else {
                    return
                }
                viewModel.getNextPage(urlString: urlString)
                tableView.tableFooterView = loadingView
                print("characters \(characters.count)")
            }
        }
    }

}

extension CharactersListViewController: CharactersListViewModelDelegate {
    func updateList(characters: RootModel) {
        self.characters.append(contentsOf: characters.results)
        nextUrl = characters.info.next
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        refreshControl.endRefreshing()
        self.tableView.reloadData()
    }

    func showError(error: Error) {
        self.showAlert(with: "Ошибка!", and: error.localizedDescription)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    func showSpinner(title: String) {
        SwiftSpinner.setTitleFont(UIFont(name: "Helvetica Neue", size: 16.0))
        SwiftSpinner.show(title, animated: true)
    }

    func hideSpinner() {
        SwiftSpinner.hide()
    }
}
