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
    
    var array = [GitCommitResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commitsTableView.delegate = self
        commitsTableView.dataSource = self

        let path = GitConstants.path
        HTTPRequestManager(path: path, method: .get, headers: nil).getGitCommits {
            response in
            switch response {
            case .success(let data):
                if let data = data {
                    self.array = data
                    DispatchQueue.main.async {
                        self.commitsTableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension GitHubCommitsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = commitsTableView.dequeueReusableCell(withIdentifier: "commitCell", for: indexPath) as? GitHubCommitsTableViewCell else { return UITableViewCell() }
        cell.messageLabel.text = array[indexPath.row].commit.message
        cell.autthorLabel.text = array[indexPath.row].commit.committer.name
        cell.shaLabel.text = array[indexPath.row].sha
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = Bundle.main.loadNibNamed("GitHubHeaderView", owner: nil, options: nil)?[0] as? GitHubHeaderView else { return nil }
        view.titleLabel.text = "Commits"
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
}
