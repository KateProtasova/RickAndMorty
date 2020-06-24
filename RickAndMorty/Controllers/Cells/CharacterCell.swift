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
    @IBOutlet private var bgView: UIView!

    override func layoutSubviews() {
           super.layoutSubviews()
           self.bgView.layer.cornerRadius = 10

        self.avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.contentMode = .scaleAspectFill
               avatarImageView.clipsToBounds = true
           self.bgView.clipsToBounds = true
        self.backgroundColor =  #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        self.bgView.backgroundColor =  .white
        self.layer.cornerRadius = 4
        self.layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)

       }

    func configureWith(character: Character, atIndex index: Int) {
        nameLabel.text = character.name
        let url = URL(string: character.image)
        avatarImageView.kf.setImage(with: url)

    }
}
