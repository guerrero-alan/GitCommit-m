//
//  GitHubModels.swift
//  GitCommit-m
//
//  Created by Alan Guerrero on 2/26/21.
//  Copyright © 2021 Alan Guerrero. All rights reserved.
//

import Foundation

// MARK: - GitCommitResponse
struct GitCommitResponse: Codable {
    let sha: String
    let commit: GitCommit
}

// MARK: - GitCommit
struct GitCommit: Codable {
    let committer: GitAuthor
    let message: String
    let tree: GitTree
}

// MARK: - GitAuthor
struct GitAuthor: Codable {
    let name, email: String
    let date: String
}

// MARK: - GitTree
struct GitTree: Codable {
    let sha: String
    let url: String
}
