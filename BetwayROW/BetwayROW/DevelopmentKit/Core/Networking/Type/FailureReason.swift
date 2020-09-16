//
//  FailureReason.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

enum FailureReason: FailureType, Equatable {
    case unknown
    case invalidClient
    case invalidResponse
    case invalidURL
    case missingRequiredHeader
    case internetConnectionOffline
    case sslError
    case httpCode(HTTPCode?)
    
    enum HTTPCode: FailureType {
        case badRequest
        case notFound
        case preconditionFailed
        case expectationFailed
        case notImplemented
        case unknown
        
        init?(rawValue int: Int) {
            switch int {
            case 400: self = .badRequest
            case 404: self = .notFound
            case 412: self = .preconditionFailed
            case 417: self = .expectationFailed
            case 501: self = .notImplemented
            default: self = .unknown
            }
        }
        
        var value: Int {
            switch self {
            case .notFound: return 404
            case .badRequest: return 400
            case .preconditionFailed: return 412
            case .expectationFailed: return 417
            case .notImplemented: return 501
            case .unknown: return 1
            }
        }
        
        var message: String? {
            var messageString: String?
            switch self {
            case .notFound: messageString = "The resource was not found"
            case .badRequest: messageString = "Bad request"
            case .preconditionFailed: messageString = "Precondition was not met"
            case .expectationFailed: messageString = "Expectation failed"
            case .notImplemented: messageString = "The request has not been implemented"
            default: break
            }
            return messageString
        }
    }
    
    init(error: Error?, responseStatusCode: Int? = 1) {
        self = FailureReason(rawValue: ((error?.code == responseStatusCode || error?.code == nil) ? responseStatusCode : error?.code) ?? 1) ?? .unknown
    }
    
    init?(rawValue int: Int) {
        switch int {
        case 1: self = FailureReason.unknown
        case 2: self = FailureReason.invalidClient
        case 4002: self = FailureReason.invalidResponse
        case 4006: self = FailureReason.invalidURL
        case 4170: self = FailureReason.missingRequiredHeader
        case -1009: self = FailureReason.internetConnectionOffline
        case -1200: self = FailureReason.sslError
        default: self = FailureReason.httpCode(HTTPCode(rawValue: int))
        }
    }
    
    var value: Int {
        switch self {
        case .unknown: return 1
        case .invalidClient: return 2
        case .invalidResponse: return 4002
        case .invalidURL: return 4006
        case .missingRequiredHeader: return 4170
        case .internetConnectionOffline: return -1009
        case .sslError: return -1200
        case .httpCode(let code): return code?.value ?? 1
        }
    }
    
    var message: String? {
        var messageString: String?
        switch self {
        case .unknown: messageString = "An unknown error occured."
        case .invalidClient: messageString = "The client is invalid or nil"
        case .invalidResponse: messageString = "The response is invalid"
        case .invalidURL: messageString = "The URL is invalid"
        case .missingRequiredHeader: messageString = "The request is missing the required headers"
        case .internetConnectionOffline: messageString = "The internet connection is offline"
        case .sslError: messageString = "An SSL error has occurred and a secure connection to the server cannot be made."
        case .httpCode(let code): return code?.message ?? "An unknown error occured."
            
        }
        return messageString
    }
}
