//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 27.05.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getData()
    }

    private func setupUI() {
        tableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    //Model
    private func getData() {
        NetworkManager.shared.fetchAllCharacters { characters in
            self.characters = characters ?? []
            self.tableView.reloadData()
        }
    }
}

extension CharactersViewController: UITableViewDataSource {

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
