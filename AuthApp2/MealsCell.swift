//
//  MealsCell.swift
//  AuthApp2
//
//  Created by Fernando Gonzalez on 10/13/21.
//

import UIKit

class MealsCell: UITableViewCell {
    
    
    @IBOutlet weak var recepieImg: UIImageView!
    @IBOutlet weak var recepieTitleLabel: UILabel!
    @IBOutlet weak var recepieDescriptionLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
