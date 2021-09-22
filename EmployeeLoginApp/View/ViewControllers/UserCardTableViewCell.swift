//
//  UserCardTableViewCell.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import UIKit

class UserCardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        applyTheme()
    }
    
    func applyTheme() {
        self.cardView.layer.cornerRadius = 5
        self.imgView.layer.borderWidth = 0.2
        self.imgView.layer.cornerRadius = 1
        self.cardView.layer.shadowColor = UIColor.gray.cgColor
        self.cardView.layer.shadowOpacity = 0.5
        self.cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
}
