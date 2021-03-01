//
//  RequestManager.swift
//  GitCommit-m
//
//  Created by Alan Guerrero on 2/26/21.
//  Copyright © 2021 Alan Guerrero. All rights reserved.
//

import Foundation

// MARK: - ViewController

struct HTTPRequestManager {
    var path: String
    var method: NetworkMethod
    var headers: [String: String]?
    
    func getGitCommits(completion: @escaping (Result<[GitCommitResponse]?, Error>) -> Void) {
        let path = self.path
        guard let url = URL(string: path)
            else {
                completion(.failure(RequestError.invalidURL))
                return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(RequestError.noResponse))
                return
            }
            guard response.statusCode < 400 else {
                completion(.failure(RequestError.httpResponse(response.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(RequestError.noData))
                return
            }
            do {
                let rawResult = try JSONDecoder().decode([GitCommitResponse].self, from: data)
                completion(.success(rawResult))
            } catch {
                completion(.failure(RequestError.decoderFailure))
            }
        }
        dataTask.resume()
    }
}

