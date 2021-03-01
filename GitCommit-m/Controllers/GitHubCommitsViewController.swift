//
//  GitHubCommitsViewController.swift
//  GitCommit-m
//
//  Created by Alan Guerrero on 2/26/21.
//  Copyright © 2021 Alan Guerrero. All rights reserved.
//

import UIKit

class GitHubCommitsViewController: UIViewController {
    
    @IBOutlet weak var commitsTableView: UITableView!
    let viewModel = GitHubCommitsViewModel()
    let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commitsTableView.delegate = self
        commitsTableView.dataSource = self
        toggleSpinnerAnimation(isOn: true)
        loadGitHubCommits()
        
    }
    
    func loadGitHubCommits() {
        viewModel.loadGitHubCommits() {
            success in
            switch success {
            case .success:
                DispatchQueue.main.async {
                    self.toggleSpinnerAnimation(isOn: false)
                    self.commitsTableView.reloadData()
                }
            case .failure(_):
                self.toggleSpinnerAnimation(isOn: false)
                return
            }
        }
    }
    
    func toggleSpinnerAnimation(isOn: Bool) {
        DispatchQueue.main.async {
            if isOn {
                self.spinner.startAnimating()
                self.commitsTableView.backgroundView = self.spinner
            } else {
                self.spinner.stopAnimating()
                self.commitsTableView.backgroundView = nil
            }
        }
    }
}

extension GitHubCommitsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = commitsTableView.dequeueReusableCell(withIdentifier: "commitCell", for: indexPath) as? GitHubCommitsTableViewCell, let response = viewModel.getCommitResponse(at: indexPath.row) else { return UITableViewCell() }
        let commit = response.commit
        let sha = response.sha
        cell.messageLabel.text = commit.message
        cell.autthorLabel.text = commit.committer.name
        cell.shaLabel.text = sha
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = Bundle.main.loadNibNamed("GitHubHeaderView", owner: nil, options: nil)?[0] as? GitHubHeaderView else { return nil }
        view.titleLabel.text = GitConstants.title
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
}
