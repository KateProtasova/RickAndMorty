//
//  DetailsCharacterViewController.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 24.06.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit
import Kingfisher

final class DetailsCharacterViewController: UIViewController {

    var character: Character?

    var infoCells: [InfoCell] = []

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var avatarImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    private func setupUI() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailsInfoCell", bundle: nil), forCellReuseIdentifier: "DetailsInfoCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = character?.name

        guard  let character = character else {
            return
        }

        let url = URL(string: character.image)
        avatarImageView.kf.setImage(with: url)
        getInfoCells(character: character)
    }

    func getInfoCells(character: Character) {
        let infoCell1: InfoCell = InfoCell(title: "Status", info: character.status)
        let infoCell2: InfoCell = InfoCell(title: "Spesies", info: character.species)
        let infoCell3: InfoCell = InfoCell(title: "Gender", info: character.gender)
        let infoCell4: InfoCell = InfoCell(title: "Loction", info: character.location.name)
        let infoCell5: InfoCell = InfoCell(title: "Created", info: character.created)

        infoCells.append(infoCell1)
        infoCells.append(infoCell2)
        infoCells.append(infoCell3)
        infoCells.append(infoCell4)
        infoCells.append(infoCell5)
        tableView.reloadData()
    }

}

extension DetailsCharacterViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsInfoCell", for: indexPath) as? DetailsInfoCell {
            cell.configureWith(info: infoCells[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

}
