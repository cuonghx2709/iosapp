//
//  YoutubeCell.swift
//  YoutubeApp
//
//  Created by cuonghx on 5/1/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit

class YoutubeCell: UITableViewCell {
    // MARK: properties
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDiscription: UILabel!
    @IBOutlet weak var imageVideo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
