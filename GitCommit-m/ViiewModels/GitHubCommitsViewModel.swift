//
//  GitHubCommitsViewModel.swift
//  GitCommit-m
//
//  Created by Alan Guerrero on 3/1/21.
//  Copyright © 2021 Alan Guerrero. All rights reserved.
//

import Foundation

final class GitHubCommitsViewModel {
    private var commitsDataArray = [GitCommitResponse]()
    
    func loadGitHubCommits(completion: @escaping (Result<Void, Error>) -> Void) {
        let path = GitConstants.path
        HTTPRequestManager(path: path, method: .get, headers: nil).getGitCommits {
            response in
            switch response {
            case .success(let data):
                if let data = data {
                    self.commitsDataArray = data
                    completion(.success(()))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func getCommitResponse(at index: Int) -> GitCommitResponse? {
        guard index < commitsDataArray.count else { return nil }
        return commitsDataArray[index]
    }
    
    func getDataCount() -> Int {
        return commitsDataArray.count
    }
}
