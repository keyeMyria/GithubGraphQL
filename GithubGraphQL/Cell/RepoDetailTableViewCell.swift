//
//  RepoDetailTableViewCell.swift
//  GithubGraphQL
//
//  Created by TechFlitter on 08/08/17.
//  Copyright © 2017 TechFlitter. All rights reserved.
//

import UIKit

class RepoDetailTableViewCell: UITableViewCell {

	@IBOutlet weak var repoNameLabel: UILabel!
	
	@IBOutlet weak var descriptionLabel: UILabel!
	
	@IBOutlet weak var urlButton: UIButton!
	
	@IBOutlet weak var createdAtLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
