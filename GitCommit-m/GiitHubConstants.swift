//
//  GiitHubConstants.swift
//  GitCommit-m
//
//  Created by Alan Guerrero on 2/26/21.
//  Copyright © 2021 Alan Guerrero. All rights reserved.
//

import Foundation

// MARK: - RequestError

enum RequestError: Error {
    case requestHandlerNil
    case invalidURL
    case noResponse
    case httpResponse(Int)
    case noData
    case decoderFailure
}

// MARK: - NetworkMethod

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - RequestError

extension RequestError: CustomStringConvertible {
    var description: String {
        switch self {
        case .requestHandlerNil:
            return "No Request Handler"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "No Response"
        case .httpResponse(let errorCode):
            return "HTTP Response: \(errorCode)"
        case .noData:
            return "No Data Returned"
        case .decoderFailure:
            return "JSONDecoder failed to generate model"
        }
    }
}

struct GitConstants {
    static let path = "https://api.github.com/repos/guerrero-alan/GitCommit-m/commits"
    static let title = "Commits"
    static let alertTitle = "We had trouble loading this repository's commits"
    static let alertMessage = "Would you like to try again?"
    static let yes = "Yes"
    static let no = "No"
}
