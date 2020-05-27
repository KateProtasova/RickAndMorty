//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 27.05.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    func configureWith(character: Character, atIndex index: Int) {
        nameLabel.text = "\(character.name)"
        let url = URL(string: "\(character.image)")
        avatarImageView.kf.setImage(with: url)
    }
}
