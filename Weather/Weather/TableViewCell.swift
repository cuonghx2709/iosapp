//
//  TableViewCell.swift
//  Weather
//
//  Created by cuonghx on 4/30/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelMain: UILabel!
    @IBOutlet weak var labeliDiscription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(temp: String, main: String, discription: String){
        self.labelTemp.text = temp
        self.labelMain.text = main
        self.labeliDiscription.text = discription
    }

}
