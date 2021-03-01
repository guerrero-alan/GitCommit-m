//
//  GitHubCommitsTableViewCell.swift
//  GitCommit-m
//
//  Created by Alan Guerrero on 2/26/21.
//  Copyright © 2021 Alan Guerrero. All rights reserved.
//

import UIKit

class GitHubCommitsTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var autthorLabel: UILabel!
    @IBOutlet weak var shaLabel: UILabel!
}

class GitHubHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
}
