//
//  ViewController.swift
//  GitCommit-m
//
//  Created by Alan Guerrero on 2/23/21.
//  Copyright © 2021 Alan Guerrero. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = "https://api.github.com/repos/guerrero-alan/GitCommit-m/commits"
        HTTPRequestManager(path: path, method: .get, headers: nil).getGitCommits {
            response in
            switch response {
            case .success(let data):
                if let data = data {
                    print(data)
                }
            case .failure(let error):
                print(error)
            }
        }

    }
}

