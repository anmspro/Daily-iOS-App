//
//  TodoCell.swift
//  todo
//
//  Created by CSE on 5/12/19.
//  Copyright © 2019 CSE. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    
    @IBOutlet weak var checkMarkImage: UIImageView!
    @IBOutlet weak var todoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
