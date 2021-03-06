//
//  ImagesTableViewCell.swift
//  DockerClient
//
//  Created by Andrew Weiss on 8/4/14.
//  Copyright (c) 2014 Andrew Weiss. All rights reserved.
//

import UIKit

class ImagesTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }

}
