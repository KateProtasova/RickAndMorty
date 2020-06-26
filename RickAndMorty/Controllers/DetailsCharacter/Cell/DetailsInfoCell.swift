//
//  DetailsInfoCell.swift
//  RickAndMorty
//
//  Created by Екатерина Протасова on 24.06.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit

class DetailsInfoCell: UITableViewCell {

    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWith(info: InfoCell) {
        infoLabel.text = info.info
        titleLabel.text = info.title

    }
}
