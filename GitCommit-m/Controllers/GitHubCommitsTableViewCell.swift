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

protocol GitHubHeaderViewProtocol: class {
    func didPressRefreshButton()
}

class GitHubHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: GitHubHeaderViewProtocol?
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        delegate?.didPressRefreshButton()
    }
}
