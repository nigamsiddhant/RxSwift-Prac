//
//  DetailTableViewCell.swift
//  Matrix
//
//  Created by Siddhant Nigam on 03/12/19.
//  Copyright © 2019 Siddhant Nigam. All rights reserved.
//

import UIKit
import Kingfisher

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var emailIdLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    var userData: Details! {
        didSet {
            if let imgUrl = URL(string: userData.imageUrl ?? "") {
                avatar.kf.setImage(with: imgUrl)
            }
            let name = userData.firstName ?? " "
            let lastName = userData.lastName ?? " "
            let emailId = userData.emailId ?? " "
            
            self.userNameLabel.text = name + " " + lastName
            self.emailIdLabel.text = emailId
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.avatar.clipsToBounds = true
        self.avatar.layer.cornerRadius = 40
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
